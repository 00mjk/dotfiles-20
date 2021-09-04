package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"path/filepath"
)

func main() {
	sc := bufio.NewScanner(os.Stdin)

	var pwd string

	args := os.Args[1:]
	switch len(args) {
	case 1:
		pwd = args[0]
	case 0:
		var err error
		pwd, err = os.Getwd()
		if err != nil {
			log.Fatal(err)
		}
	default:
		log.Fatal("the only argument allowed is a base directory")
	}

	dirMap := make(map[string]struct{})

	for sc.Scan() {
		fpath := sc.Text()
		dirpath := filepath.Dir(fpath)

		if _, ok := dirMap[fpath]; ok {
			continue
		}
		if _, ok := dirMap[dirpath]; ok {
			continue
		}

		var fullfpath string
		if filepath.IsAbs(fpath) {
			fullfpath = fpath
		} else {
			fullfpath = filepath.Join(pwd, fpath)
		}

		fileInfo, err := os.Stat(fullfpath)
		if err != nil {
			log.Fatal(err)
		}

		var dir string
		if fileInfo.IsDir() {
			dir = fpath
		} else {
			dir = dirpath
		}

		dirMap[dir] = struct{}{}

		fmt.Println(dir)
	}

	if err := sc.Err(); err != nil {
		log.Fatal(err)
	}
}
