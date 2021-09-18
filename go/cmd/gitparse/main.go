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
	// a modified file is indicated with an M in the second column of the short
	// status output
	reModifiedFile = regexp.MustCompile(`^.M`)

	// an untracked file is indicated with a ? in the first column
	reUntrackedFile = regexp.MustCompile(`^\?`)
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
	var anyModifiedFiles, anyUntrackedFiles string

	for sc.Scan() {
		if reModifiedFile.Match(sc.Bytes()) {
			anyModifiedFiles = "modified"
			continue
		}
		if reUntrackedFile.Match(sc.Bytes()) {
			anyUntrackedFiles = "added"
			continue
		}
	}
	if sc.Err() != nil {
		return "", sc.Err()
	}

	// 3) emit the comma separate output
	return fmt.Sprintf(
		"%v,%s,%s,%s,%s,%s",
		anyModifiedFiles,
		anyUntrackedFiles,
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
