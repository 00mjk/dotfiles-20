package main

import (
	"bufio"
	"bytes"
	"errors"
	"fmt"
	"io"
	"log"
	"os/exec"
	"regexp"
)

var (
	reBranch   = regexp.MustCompile(`^## ([^\.]+)`)
	reUpstream = regexp.MustCompile(`\.{3}([^\s]+)`)
	reAhead    = regexp.MustCompile(`ahead (\d+)`)
	reBehind   = regexp.MustCompile(`behind (\d+)`)
)

func main() {
	log.SetFlags(0)

	// 1) get the git status
	cmd := exec.Command("/usr/bin/env", "bash", "-c", "git status --branch --short")
	out, err := cmd.Output()
	if err != nil {
		log.Fatalf("executing git command: %v", err)
	}
	br := bufio.NewReader(bytes.NewReader(out))

	// 2) get the header, which will be in the format:
	// "## main...origin/main [ahead 13, behind 42]"
	header, err := br.ReadBytes('\n')
	if err != nil {
		log.Fatalf("reading git status header: %v", err)
	}
	header = header[:len(header)-1] // trim newline

	// 3) try and read past the header, if successful it means there are changes
	var isDirty string
	_, err = br.ReadBytes('\n')
	if err != nil && !errors.Is(err, io.EOF) {
		log.Fatalf("reading first file from git status: %v", err)
	}
	if err == nil {
		isDirty = "dirty"
	}

	// 4) emit the comma separate output
	fmt.Printf(
		"%v,%s,%s,%s,%s",
		isDirty,
		extract(reBranch, header),
		extract(reUpstream, header),
		extract(reAhead, header),
		extract(reBehind, header),
	)
}

func extract(re *regexp.Regexp, line []byte) string {
	if m := re.FindSubmatch(line); len(m) == 2 {
		return string(m[1])
	}

	return ""
}
