#conditions in python

# if statement
a = 33
b = 200
if b > a:
  print("b is greater than a")

# elif statement
#explanation: if the condition in the if statement is False, then check the condition in the elif statement
a = 33
b = 33
if b > a:
  print("b is greater than a")
elif a == b:
    print("a and b are equal")

# else statement
#explanation: if the condition in the if statement is False, then check the condition in the elif statement
# if the condition in the elif statement is False, then execute the else statement
a = 200
b = 33
if b > a:
  print("b is greater than a")
elif a == b:
    print("a and b are equal")
else:
    print("a is greater than b")

# short hand if
a = 200
b = 33
if a > b: print("a is greater than b")

# short hand if else
a = 2
b = 330
print("A") if a > b else print("B")


# and operator
a = 200
b = 33
c = 500
if a > b and c > a:
  print("Both conditions are True")


#while loop
i = 1
while i < 6:
  print(i)
  i += 1

#break statement
i = 1
while i < 6:
  print(i)
  if i == 3:
    break
  i += 1


#continue statement
i = 0
while i < 6:
  i += 1
  if i == 3:
    continue
  print(i)

#for loop
fruits = ["apple", "banana", "cherry"]
for x in fruits:
  print(x)

#range function
for x in range(6):
  print(x)


#nested loops
adj = ["red", "big", "tasty"]
fruits = ["apple", "banana", "cherry"]
for x in adj:
  for y in fruits:
    print(x, y)




