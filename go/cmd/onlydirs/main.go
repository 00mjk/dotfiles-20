package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"path/filepath"
)

func main() {
	// 1. get a list of files from stdin
	sc := bufio.NewScanner(os.Stdin)

	var pwd string

	// 2. take an optional base directory...
	args := os.Args[1:]
	switch len(args) {
	case 1:
		pwd = args[0]
	case 0: // ...or 3. default to the current directory if not given
		var err error
		pwd, err = os.Getwd()
		if err != nil {
			log.Fatal(err)
		}
	default:
		log.Fatal("the only argument allowed is a base directory")
	}

	// 4. prepare to reject duplicates
	seen := make(map[string]struct{})

	for sc.Scan() {
		// 5. skip to the next entry if the path is already in the results
		fpath := sc.Text()
		if _, ok := seen[fpath]; ok {
			continue
		}

		dirpath := filepath.Dir(fpath)
		if _, ok := seen[dirpath]; ok {
			continue
		}

		// 6. normalise the path to a full path
		var fullfpath string
		if filepath.IsAbs(fpath) {
			fullfpath = fpath
		} else {
			fullfpath = filepath.Join(pwd, fpath)
		}

		// 7. get the info about the path
		fileInfo, err := os.Stat(fullfpath)
		if err != nil {
			log.Fatal(err)
		}

		// 8. determine the directory (could be the given path itself)
		var dir string
		if fileInfo.IsDir() {
			dir = fpath
		} else {
			dir = dirpath
		}

		// 9. mark the path as seen
		seen[dir] = struct{}{}

		// 10. print it
		fmt.Println(dir)
	}

	if err := sc.Err(); err != nil {
		log.Fatal(err)
	}
}
