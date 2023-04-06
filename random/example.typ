#import "random.typ"
#import random: rand, randint, step_seed, shuffle

= Random number examples

#let seed = 1000 // input any number here as a seed
List of 10 random numbers:
#for i in range(10) {
    seed = step_seed(seed)
    [#linebreak()#rand(seed)]
}

Another random number:
#{
    seed = step_seed(seed)
    [#rand(seed)]
}

Random integer between 1 and 100:
#{
    seed = step_seed(seed)
    [#randint(1, 100, seed)]
}

Shuffling an array:\
#let arr_demo = (1, 2, 4, 3, 5, 7)
Original array: #arr_demo\
#{seed = step_seed(seed)}
Shuffled array: #shuffle(arr_demo, seed)\
#{seed = step_seed(seed)}
Shuffled again: #shuffle(arr_demo, seed)


#let n = 2000
Monte Carlo Simulation to Derive the Value of Pi ($n=#n$):\
#{
    let count = 0
    box(
        width: 20em,
        height: 20em,
        {
            place(
                top + left,
                line(start: (50%, 0pt), end: (50%, 100%))
            )
            place(
                top + left,
                line(start: (0pt, 50%), end: (100%, 50%))
            )
            place(
                center + horizon,
                circle(radius: 10em)
            )
            place(
                center + horizon,
                square(
                    size: 20em
                )
            )
            for i in range(n) {
                seed = step_seed(seed)
                let x = rand(seed)
                seed = step_seed(seed)
                let y = rand(seed)
                place(
                    center + horizon,
                    dx: x * 1/2*100%,
                    dy: -y * 1/2*100%,
                    circle(
                        radius: 1pt,
                        fill: red
                    )
                )
                // count the hts mathematically
                if calc.sqrt(calc.pow(x, 2) + calc.pow(y, 2)) < 1 {count += 1}
            }
        }
    )
    let strcount = [#count] // redefined so that I can display them as maths
    let strn = [#n]
    let ratio = count / n
    let approximation = ratio * 4
    [
    #linebreak()
    Number of dots inside the circle: #count\
    $n = #n$\
    Ratio inside the circle: $frac(strcount, strn) = #{count / n}$\
    Area inside the quarter-circle: $frac(pi, 4) r^2$\
    Area inside the square quadrant: $r^2$\
    Expected ratio in the circle: $frac(pi, 4)$\
    $therefore pi approx #ratio dot.c 4 = #approximation$
    ]
}