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

	printSimple("NORMAL / DEFAULT", normalForegrounds)
	printSimple("BRIGHT / DEFAULT", brightForegrounds)
	printSimple("DEFAULT / NORMAL", normalBackgrounds)
	printSimple("DEFAULT / BRIGHT", brightBackgrounds)
	printCombo("NORMAL / NORMAL", normalForegrounds, normalBackgrounds)
	printCombo("NORMAL / BRIGHT", normalForegrounds, brightBackgrounds)
	printCombo("BRIGHT / NORMAL", brightForegrounds, normalBackgrounds)
	printCombo("BRIGHT / BRIGHT", brightForegrounds, brightBackgrounds)
}

func printTitle(text string) {
	fmt.Println("————————————————————————————————————————————————————————————————————————")
	fmt.Println(text)
	fmt.Println()
}

func printCombo(title string, normalForegrounds, normalBackgrounds []color.Attribute) {
	printTitle(title)

	for _, bg := range normalBackgrounds {
		for _, fg := range normalForegrounds {
			color.Set(fg, bg)
			fmt.Printf(" %v/%v ", fg, bg)
			color.Unset()
		}
		fmt.Println()
	}
}

func printSimple(title string, attributes []color.Attribute) {
	printTitle(title)

	color.Unset()
	fmt.Printf(" 00 ")
	color.Unset()
	for _, attr := range attributes {
		color.Set(attr)
		fmt.Printf(" %v ", attr)
		color.Unset()
	}
	fmt.Println()

	color.Set(color.ReverseVideo)
	fmt.Printf(" 00 ")
	color.Unset()
	for _, attr := range attributes {
		color.Set(attr, color.ReverseVideo)
		fmt.Printf(" %v ", attr)
		color.Unset()
	}
	fmt.Println()
}
