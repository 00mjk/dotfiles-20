package main

import (
	"bufio"
	"bytes"
	"errors"
	"fmt"
	"log"
	"os/exec"
	"regexp"
)

// Header patterns.
//
// The complete header will be for example:
//
//     ## foo.bar...origin/foo.bar [ahead 42, behind 137]
//
var (
	// local branch: from after the first space until either the end or the
	// three dots (a branch name can contain dots)
	reBranch = regexp.MustCompile(`^## (.+?)(?:$|\.{3})`)

	// remote tracking branch: from after the three dots to the first whitespace
	reUpstream = regexp.MustCompile(`\.{3}([^\s]+)`)

	// num of commits ahead or behing is the digits after the corresponding word,
	// if present
	reAhead  = regexp.MustCompile(`ahead (\d+)`)
	reBehind = regexp.MustCompile(`behind (\d+)`)
)

// File list patterns.
var (
	// a staged file is indicated by an M (if modified), an A (if new) or an
	// R (if renamed) in the first column of the short status output
	reModifiedStaged = regexp.MustCompile(`^M|^A|^R`)

	// a file modified but not staged is indicated by an M in the second column
	reModifiedNotStaged = regexp.MustCompile(`^.M`)

	// an untracked file is indicated with a ? in the first column
	reUntracked = regexp.MustCompile(`^\?`)
)

func main() {
	log.SetFlags(0)
	log.SetPrefix("gitparse")

	gitStatus, err := exec.Command("/usr/bin/env", "bash", "-c", "git status --branch --short").Output()
	if err != nil {
		log.Fatal(err)
	}

	gitStatusSummary, err := ParseGit(gitStatus)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println(gitStatusSummary)
}

func ParseGit(shortGitStatus []byte) (string, error) {
	sc := bufio.NewScanner(bytes.NewReader(shortGitStatus))

	// 1) get the header, which will be in the format:
	//    "## main...origin/main [ahead 13, behind 42]"
	if !sc.Scan() {
		if sc.Err() != nil {
			return "", sc.Err()
		}
		return "", errors.New("git output was empty")
	}

	header := sc.Text()

	// 2) try and read past the header, if successful it means there are changes
	var anyModifiedStaged, anyModifiedNotStaged, anyUntracked string

	for sc.Scan() {
		if reModifiedStaged.Match(sc.Bytes()) {
			anyModifiedStaged = "modifiedStaged"
			continue
		}
		if reModifiedNotStaged.Match(sc.Bytes()) {
			anyModifiedNotStaged = "modifiedNonStaged"
			continue
		}
		if reUntracked.Match(sc.Bytes()) {
			anyUntracked = "added"
			continue
		}
	}
	if sc.Err() != nil {
		return "", sc.Err()
	}

	// 3) emit the comma separate output
	return fmt.Sprintf(
		"%s,%s,%s,%s,%s,%s,%s",
		anyModifiedStaged,
		anyModifiedNotStaged,
		anyUntracked,
		extract(reBranch, header),
		extract(reUpstream, header),
		extract(reAhead, header),
		extract(reBehind, header),
	), nil
}

func extract(re *regexp.Regexp, line string) string {
	if m := re.FindStringSubmatch(line); len(m) >= 2 {
		return string(m[1])
	}

	return ""
}
