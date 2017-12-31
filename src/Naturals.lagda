---
title     : "Naturals: Natural numbers"
layout    : page
permalink : /Naturals
---

The night sky holds more stars than I can count, though less than five
thousand are visible to the naked sky.  The observable universe
contains about seventy sextillion stars.

But the number of stars is finite, while natural numbers are infinite.
Count all the stars, and you will still have as many natural numbers
left over as you started with.


## The naturals are an inductive datatype

Everyone is familiar with the natural numbers:

    0
    1
    2
    3
    ...

and so on. We write `ℕ` for the *type* of natural numbers, and say that
`0`, `1`, `2`, `3`, and so on are *values* of type `ℕ`.  In Agda,
we indicate this by writing

    0 : ℕ
    1 : ℕ
    2 : ℕ
    3 : ℕ
    ...

and so on.

The set of natural numbers is infinite, yet we can write down
its definition in just a few lines.  Here is the definition
as a pair of inference rules:

    --------
    zero : ℕ

    n : ℕ
    ---------
    suc n : ℕ

And here is the definition in Agda:
\begin{code}
data ℕ : Set where
  zero : ℕ
  suc  : ℕ → ℕ
\end{code}
Here `ℕ` is the name of the *datatype* we are defining,
and `zero` and `suc` (short for *successor*) are the
*constructors* of the datatype.

Both definitions above tell us the same two things:

1. The term `zero` is a natural number.
2. If `n` is a natural number, then the term `suc n` is also a natural number.

Further, these two rules give the *only* ways of creating natural numbers.
Hence, the possible natural numbers are

    zero
    suc zero
    suc (suc zero)
    suc (suc (suc zero))
    ...

We write `0` as shorthand for `zero`; and `1` is shorthand
for `suc zero`, the successor of zero, that is, the natural that comes
after zero; and `2` is shorthand for `suc (suc zero)`, which is the
same as `suc 1`, the successor of one; and `3` is shorthand for the
successor of two; and so on.

**Exercise 1** Write out `7` in longhand.


### Unpacking the inference rules

Let's unpack the inference rules.  Each inference rule consists of zero
or more *judgments* written above a horizontal line, called the *hypotheses*,
and a single judgment written below, called the *conclusion*.  

The first rule has no hypotheses, and the conclusion asserts that zero
is a natural.  The second rule has one hypothesis, which assumes that
`n` is a natural number, and the conclusion asserts that `suc n` is a
natural number.


### Unpacking the Agda definition

Let's unpack the Agda definition. The keyword `data` tells us this is an
inductive definition, that is, that we are defining a new datatype
with constructors.  The phrase

    ℕ : Set

tells us that `ℕ` is the name of the new datatype, and that it is a
`Set`, which is the way in Agda of saying that it is a type.  The
keyword `where` separates the declaration of the datatype from the
declaration of its constructors. Each constructor is declared on a
separate line, which is indented to indicate that it belongs to the
corresponding `data` declaration.  The lines

    zero : ℕ
    suc : ℕ → ℕ

tell us that `zero` is a natural number and that `suc` takes a natural
number as argument and returns a natural number.

Here `ℕ` and `→` are unicode symbols that you won't find on your
keyboard. At the end of each chapter is a list of all the unicode used
in the chapter, including instructions on how to type them in the
Emacs text editor.


### The story of creation

Let's look again at the definition of natural numbers:

1. The term `zero` is a natural number.
2. If `n` is a natural number, then the term `suc n` is also a natural number.

Wait a minute! The second line defines natural numbers
in terms of natural numbers. How can that posssibly be allowed?
Isn't this as useless as claiming `Brexit means Brexit`?

In fact, it is possible to assign our definition a meaning without
resorting to any unpermitted circularities.  Furthermore, we can do so
while only working with *finite* sets and never referring to the
entire *infinite* set of natural numbers.

We will think of it as a creation story.  To start with, we know about
no natural numbers at all.

    -- in the beginning, there are no natural numbers

Now, we apply the rules to all the natural numbers we know about.  One
rule tells us that `zero` is a natural number, so we add it to the set
of known natural numbers.  The other rule tells us that if `n` is a
natural number (on the day before today) then `suc n` is also a
natural number (today).  We didn't know about any natural numbers
before today, so we don't add any natural numbers of the form `suc n`.

    -- on the first day, there is one natural number   
    zero

Then we repeat the process, so on the next day we know about all the
numbers from the day before, plus any numbers added by the rules.  One
rule tells us that `zero` is a natural number, but we already knew
that. But now the other rule tells us that since `zero` was a natural
number yesterday, `suc zero` is a natural number today.

    -- on the second day, there are two natural numbers
    zero
    suc zero

And we repeat the process again. Once more, one rule tells us what
we already knew, that `zero` is a natural number.  And now the other rule
tells us that since `zero` and `suc zero` are both natural numbers, then
`suc zero` and `suc (suc zero)` are natural numbers. We already knew about
the first of these, but the second is new.

    -- on the third day, there are three natural numbers
    zero
    suc zero
    suc (suc zero)

You've probably got the hang of it by now.

    -- on the fourth day, there are four natural numbers
    zero
    suc zero
    suc (suc zero)
    suc (suc (suc zero))

The process continues.  On the *n*th day there will be *n* distinct
natural numbers. Note that in this way, we only talk about finite sets
of numbers. Every natural number will appear on some given finite
day. In particular, the number *n* first appears on day *n+1*. And we
never actually define the set of numbers in terms of itself. Instead,
we define the set of numbers on day *n+1* in terms of the set of
numbers on day *n*.

A process like this one is called *inductive*. We start with nothing, and
build up a potentially infinite set by applying rules that convert one
finite set into another finite set.

The rule defining zero is called a *base case*, because it introduces
a natural number even when we know no other natural numbers.  The rule
defining successor is called an *inductive case*, because it
introduces more natural numbers once we already know some.  Note the
crucial role of the base case.  If we only had inductive rules, then
we would have no numbers in the beginning, and still no numbers on the
second day, and on the third, and so on.  An inductive definition lacking
a base case is useless, as in the phrase "Brexit means Brexit".

A philosopher might note that our reference to the first day, second
day, and so on, implicitly involves an understanding of natural
numbers.  In this sense, our definition might indeed be regarded as in
some sense circular.  We won't worry about the philosophy, but are ok
with taking some intuitive notions---such as counting---as given.

While the natural numbers have been understood for as long as people
could count, this way of viewing the natural numbers is relatively
recent.  It can be traced back to Richard Dedekind's paper "*Was sind
und was sollen die Zahlen?*" (What are and what should be the
numbers?), published in 1888, and Giuseppe Peano's book "*Arithmetices
principia, nova methodo exposita*" (The principles of arithmetic
presented by a new method), published the following year.


### A useful pragma

In Agda, any line beginning `--`, or any code enclosed between `{-`
and `-}` is considered a *comment*.  Comments have no effect on the
code, with the exception of one special kind of comment, called a
*pragma*, which is enclosed between `{-#` and `#-}`.

Including the line
\begin{code}
{-# BUILTIN NATURAL ℕ #-}
\end{code}
tells Agda that `ℕ` corresponds to the natural numbers, and hence one
is permitted to type `0` as shorthand for `zero`, `1` as shorthand for
`suc zero`, `2` as shorthand for `suc (suc zero)`, and so on.  The
declaration is not permitted unless the type given has two constructors,
one corresponding to zero and one to successor.

As well as enabling the above shorthand, the pragma also enables a
more efficient internal representation of naturals as the Haskell type
integer.  Representing the natural *n* with `zero` and `suc`
requires space proportional to *n*, whereas representing it as an integer in
Haskell only requires space proportional to the logarithm of *n*.  In
particular, if *n* is less than 2⁶⁴, it will require just one word on
a machine with 64-bit words.


## Operations on naturals are recursive functions

Now that we have the natural numbers, what can we do with them?
An obvious first step is to define basic operations such as
addition and multiplication.

As a child I spent much time memorising tables of addition and
multiplication.  At first the rules seemed tricky and I would often
make mistakes.  So it came as a shock to realise that all of addition
can be precisely defined in just a couple of lines, and the same is true of
multiplication.

Here is the definition of addition in Agda:
\begin{code}
_+_ : ℕ → ℕ → ℕ
zero    + n  =  n                -- (i)
(suc m) + n  =  suc (m + n)      -- (ii)
\end{code}

Let's unpack this definition.  Addition is an infix operator.  It is
written with underbars where the arguement go, hence its name is
`_+_`.  It's type, `ℕ → ℕ → ℕ`, indicates that it accepts two naturals
and returns a natural.  There are two ways to construct a natural,
with `zero` or with `suc`, so there are two lines defining addition,
labeled with comments as (i) and (ii).  Line (i) says that
adding zero to a number (`zero + n`) returns that number (`n`). Line
(ii) says that adding the successor of a number to another number
(`(suc m) + n`) returns the successor of adding the two numbers (`suc
(m+n)`).  We say we are using *pattern matching* when we use a
constructor applied to a term as an argument, such as `zero` in (i)
or `(suc m)` in (ii).

If we write `zero` as `0` and `suc m` as `1 + m`, we get two familiar equations.

   0       + n  =  n
   (1 + m) + n  =  1 + (m + n)

The first follows because zero is a left identity for addition,
and the second because addition is associative.  In its most general
form, associativity is written

   (m + n) + p  =  m + (n + p)

meaning that the order of parentheses is irrelevant.  We get the
second equation from this one by taking `m` to be `1`, `n` to be `m`,
and `p` to be `n`.

The definition is *recursive*, in that the last line defines addition
in terms of addition.  As with the inductive definition of the
naturals, the apparent circularity is not a problem.  It works because
addition of larger numbers is defined in terms of addition of smaller
numbers.  Such a definition is called *well founded*.

For example, let's add two and three.

       2 + 3
    =    { expand shorthand }
       (suc (suc zero)) + (suc (suc (suc zero)))
    =    { by (ii) }
       suc ((suc zero) + (suc (suc (suc zero))))
    =    { by (ii) }
       suc (suc (zero + (suc (suc (suc zero)))))
    =    { by (i) }
       suc (suc (suc (suc (suc zero))))
    =    { compress longhand }
       5

We can write this more compactly by only expanding shorthand as needed.

       2 + 3
    =    { by (ii) }
       suc (1 + 3)
    =    { by (ii) }
       suc (suc (0 + 3))
    =    { by (i) }
       suc (suc 3)
    =    
       5

The first use of (ii) matches by taking `m = 1` and `n = 3`,
The second use of (ii) matches by taking `m = 0` and `n = 3`,
and the use of (i) matches by taking `n = 3`.

**Exercise** Compute `3 + 4` by the same technique.


### Multiplication

Once we have defined addition, we can define multiplication
as repeated addition.
\begin{code}
_*_ : ℕ → ℕ → ℕ
zero * n     =  zero           -- (iii)
(suc m) * n  =  n + (m * n)    -- (iv)
\end{code}

Again, rewriting gives us two familiar equations.

  0       * n  =  0
  (1 + m) * n  =  n + (m * n)

The first follows because zero times anything is zero,
and the second follow because multiplication distributes
over addition.  In its most general form, distribution of
multiplication over addition is written

  (m + n) * p  =  (m * p) + (n * p)

We get the second equation from this one by taking `m` to be `1`, `n`
to be `m`, and `p` to be `n`, and then using the fact that one is a
left identity for multiplication, so `1 * n = n`.

Again, the definition is well-founded in that multiplication of
larger numbers is defined in terms of multiplication of smaller numbers.
 
For example, let's multiply two and three.

       2 * 3
    =    {by (iv)}
       3 + (1 * 3)
    =    {by (iv)}
       3 + (3 + (0 * 3))
    =    {by (iii)}
       3 + (3 + 0)
    =
       6

The first use of (iv) matches by taking `m = 1` and `n = 3`,
The second use of (iv) matches by taking `m = 0` and `n = 3`,
and the use of (iii) matches by taking `n = 3`.

**Exercise** Compute `3 * 4` by the same technique.


### Exponentiation

Similarly, once we have defined multiplication, we can define
exponentiation as repeated multiplication.
\begin{code}
_^_ : ℕ → ℕ → ℕ
n ^ zero     =  suc zero       -- (v)
n ^ (suc m)  =  n * (n ^ m)    -- (vi)
\end{code}

**Exercise** Compute `4 ^ 3`.


### Monus

We can also define subtraction.  Since there are no negative
natural numbers, if we subtract a larger number from a smaller
number we will take the result to be zero.  This adaption of
subtraction to naturals is called *monus* (as compared to *minus*).

Monus is our first example of a definition that uses pattern
matching against both arguments.
\begin{code}
_∸_ : ℕ → ℕ → ℕ
m       ∸ zero     =  m         -- (vii)
zero    ∸ (suc n)  =  zero      -- (viii)
(suc m) ∸ (suc n)  =  m ∸ n     -- (ix)
\end{code}
We can do a simple analysis to show that all the cases are covered.

  * The second argument is either `zero` or `suc n` for some `n`.
    + If it is `zero`, then equation (vii) applies.
    + If it is `suc n`, then the first argument is either `zero`
      or `suc m` for some `m`.
      - If it is `zero`, then equation (viii) applies.
      - If it is `suc m`, then equation (ix) applies.

Again, the recursive definition is well-founded because
monus on bigger numbers is defined in terms of monus on
small numbers.

For example, let's subtract two from three.

       3 ∸ 2
    =    {by (ix)}
       2 ∸ 1
    =    {by (ix)}
       1 ∸ 0
    =    {by (vii)}
       1

We did not use equation (viii) at all, but it will be required
if we try to subtract a smaller number from a larger one.

       2 ∸ 3
    =    {by (ix)}
       1 ∸ 2
    =    {by (ix)}
       0 ∸ 1
    =    {by (viii)}
       0

**Exercise** Compute `5 ∸ 3` and `3 ∸ 5` by the same technique.

### The story of creation, revisited

As with the definition of the naturals by induction, in the definition
of addition by recursion we have defined addition in terms of addition.

Again, it is possible to assign our definition a meaning without
resorting to unpermitted circularities.  We do so by reducing our
definition to equivalent inference rules for judgements about equality.

    n : ℕ
    ------------
    zero + n = n

    m + n = p
    -------------------
    (suc m) + n = suc p

Here we assume we have already defined the infinite set of natural
numbers, specifying the meaning of the judgment `n : ℕ`.  The first
inference rule asserts that if `n` is a natural number then adding
zero to it gives `n`, and the second rule asserts that if adding `m`
and `n` gives `p`, then adding `suc m` and `n` gives `suc p`.

Now we can resort to a similar creation story, where now we are
concerned with judgements about addition.

  -- in the beginning, we know nothing about addition

Now, we apply the rules to all the judgment we know about.
One rule tells us that `zero + n = n` for every natural `n`,
so we add all those equations.  The other rule tells us that if
`m + n = p` (on the day before today) then `suc m + n = suc p`
(today).  We didn't know any equations about addition before today,
so that rule doesn't give us any equations.

  -- on the first day, we know about addition of 0
  0 + 0 = 0     0 + 1 = 1    0 + 2 = 2     ...

Then we repeat the process, so on the next day we know about all the
equations from the day before, plus any equations added by the rules.  One
rule tells us that `zero + n = n` for every natural `n`, but we already knew
that. But now the other rule tells us that for every equation `m + n = p`
that we knew yesterday, we know `suc m + n = suc p` today.

  -- on the second day, we know about addition of 0 and 1
  0 + 0 = 0     0 + 1 = 1    0 + 2 = 2     ...
  1 + 0 = 1     1 + 1 = 2    1 + 2 = 3     ...

And we repeat the process again.  

  -- on the third day, we know about addition of 0, 1, and 2
  0 + 0 = 0     0 + 1 = 1    0 + 2 = 2     ...
  1 + 0 = 1     1 + 1 = 2    1 + 2 = 3     ...
  2 + 0 = 2     2 + 1 = 3    2 + 2 = 4     ...

You've probably got the hang of it by now.

The process continues. On the *m*th day we will know all the equations
where the first number is less than *m*.  As before, there is both a
base case (line (i) of the definition) and an inductive case (line
(ii)).

As we can see, the reasoning that justifies inductive and
recursive definitions is quite similar, and they might be considered
as two sides of the same coin.


### Precedence

We often use *precedence* to avoid writing too many parentheses.
Application *binds more tightly than* (or *has precedence over*) any
operator, and so we may write `suc m + n` to mean `(suc m) + n`.
As another example, we say that multiplication binds more tightly than
addition, and so write `n + m * n` to mean `n + (m * n)`.
We also sometimes say that addition is *associates to the left*, and
so write `m + n + p` to mean `(m + n) + p`.

In Agda, it is built-in that application binds more tightly than any
operator, but the precedence and associativity of infix operators
needs to be declared.
\begin{code}
infixl 7  _*_
infixl 6  _+_  _∸_
\end{code}
This states that infix operators `_*_`, `_+_`, and `_∸_` all associate
to the left, and that `_*_` has precedence level 7 and `_+_` and `_∸_`
have precedence level 6, and so multiplication binds more tightly than
both addition and subtraction.  One can also write `infixr` to
indicate that an operator associates to the right, or just `infix`
to indicate that it has no associativity and parentheses are always
required to disambiguate.

### More pragmas

Inluding the lines
\begin{code}
{-# BUILTIN NATPLUS _+_ #-}
{-# BUILTIN NATTIMES _*_ #-}
{-# BUILTIN NATMINUS _∸_ #-}
\end{code}
tells Agda that these three operators correspond to the usual ones,
and enables it to perform these computations using the corresponing
Haskell operators on the integer type.  Representing naturals with
`zero` and `suc` requires time proportional to *m* to add *m* and *n*,
whereas representing naturals as integers in Haskell requires time
proportional to the larger of the logarithms of *m* and *n*.  In
particular, if *m* and *n* are both less than 2⁶⁴, it will require
constant time on a machine with 64-bit words.  Similarly, representing
naturals with `zero` and `suc` requires time proportional to the
product of *m* and *n* to multiply *m* and *n*, whereas representing
naturals as integers in Haskell requires time proportional to the sum
of the logarithms of *m* and *n*.


## Equality is also an inductive datatype

## Proofs over naturals are also recursive functions


## Unicode

In each chapter, we will list all unicode characters used at the end.
In this chapter we use the following.

    ℕ  U+2115:  DOUBLE-STRUCK CAPITAL N (\bN)  
    →  U+2192:  RIGHTWARDS ARROW (\to, \r)
    ∸  U+2238:  DOT MINUS (\.-)
    ∀  U+2200:  FOR ALL (\forall)
    λ  U+03BB:  GREEK SMALL LETTER LAMBDA (\Gl, \lambda)
