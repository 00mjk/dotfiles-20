package main

import (
	"fmt"

	"github.com/fatih/color"
)

func main() {
	normalBackgrounds := []color.Attribute{
		color.BgBlack,
		color.BgRed,
		color.BgGreen,
		color.BgYellow,
		color.BgBlue,
		color.BgMagenta,
		color.BgCyan,
		color.BgWhite,
	}
	brightBackgrounds := []color.Attribute{
		color.BgHiBlack,
		color.BgHiRed,
		color.BgHiGreen,
		color.BgHiYellow,
		color.BgHiBlue,
		color.BgHiMagenta,
		color.BgHiCyan,
		color.BgHiWhite,
	}
	normalForegrounds := []color.Attribute{
		color.FgBlack,
		color.FgRed,
		color.FgGreen,
		color.FgYellow,
		color.FgBlue,
		color.FgMagenta,
		color.FgCyan,
		color.FgWhite,
	}
	brightForegrounds := []color.Attribute{
		color.FgHiBlack,
		color.FgHiRed,
		color.FgHiGreen,
		color.FgHiYellow,
		color.FgHiBlue,
		color.FgHiMagenta,
		color.FgHiCyan,
		color.FgHiWhite,
	}

	fmt.Println("————————————————————————————————————————————————————————————————————————")
	fmt.Println("▶ NO COLOURS")
	color.Unset()
	fmt.Printf(" FG/BG █ ")
	color.Unset()
	color.Set(color.ReverseVideo)
	fmt.Println(" BG/FG █ ")
	color.Unset()

	printSimple("NORMAL FOREGROUND / DEFAULT BACKGROUND (AND REVERSE)", normalForegrounds)
	printSimple("BRIGHT FOREGROUND / DEFAULT BACKGROUND (AND REVERSE)", brightForegrounds)
	printSimple("DEFAULT FOREGROUND / NORMAL BACKGROUND (AND REVERSE)", normalBackgrounds)
	printSimple("DEFAULT FOREGROUND / BRIGHT BACKGROUND (AND REVERSE)", brightBackgrounds)

	printCombo("NORMAL FOREGROUNDS / NORMAL BACKGROUNDS", normalForegrounds, normalBackgrounds)
	printCombo("NORMAL FOREGROUNDS / BRIGHT BACKGROUNDS", normalForegrounds, brightBackgrounds)
	printCombo("BRIGHT FOREGROUNDS / NORMAL BACKGROUNDS", brightForegrounds, normalBackgrounds)
	printCombo("BRIGHT FOREGROUNDS / BRIGHT BACKGROUNDS", brightForegrounds, brightBackgrounds)
}

func toANSI(c color.Attribute) color.Attribute {
	switch {
	case c <= normalFgLimit:
		return c - 30
	case c <= normalBgLimit:
		return c - 40
	case c <= brightFgLimit:
		return c - 82
	case c <= brightBgLimit:
		return c - 92
	default:
		panic("check the values")
	}
}

func printTitle(text string) {
	fmt.Println("————————————————————————————————————————————————————————————————————————")
	fmt.Println("▶", text)
}

const (
	normalFgLimit = 37
	normalBgLimit = 47
	brightFgLimit = 97
	brightBgLimit = 107
)

func printFGBG(c color.Attribute) {
	color.Set(c)
	defer color.Unset()

	switch {
	case c <= normalFgLimit:
		fmt.Printf(" %2v|BG █ ", toANSI(c))
	case c <= normalBgLimit:
		fmt.Printf(" FG|%-2v █ ", toANSI(c))
	case c <= brightFgLimit:
		fmt.Printf(" %2v|BG █ ", toANSI(c))
	case c <= brightBgLimit:
		fmt.Printf(" FG|%-2v █ ", toANSI(c))
	default:
		panic("check the values")
	}
}

func printFGBGReverse(c color.Attribute) {
	color.Set(c, color.ReverseVideo)
	defer color.Unset()

	switch {
	case c <= normalFgLimit:
		fmt.Printf(" BG|%-2v █ ", toANSI(c))
	case c <= normalBgLimit:
		fmt.Printf(" %2v|FG █ ", toANSI(c))
	case c <= brightFgLimit:
		fmt.Printf(" BG|%-2v █ ", toANSI(c))
	case c <= brightBgLimit:
		fmt.Printf(" %2v|FG █ ", toANSI(c))
	default:
		panic("check the values")
	}
}

func printSimple(title string, attributes []color.Attribute) {
	printTitle(title)

	for _, attr := range attributes {
		printFGBG(attr)
	}
	fmt.Println()
	for _, attr := range attributes {
		printFGBGReverse(attr)
	}
	fmt.Println()
}

func printCombo(title string, normalForegrounds, normalBackgrounds []color.Attribute) {
	printTitle(title)

	for _, bg := range normalBackgrounds {
		for _, fg := range normalForegrounds {
			color.Set(fg, bg)
			fmt.Printf(" %2v/%-2v █ ", toANSI(fg), toANSI(bg))
			color.Unset()
		}
		fmt.Println()
	}
}
