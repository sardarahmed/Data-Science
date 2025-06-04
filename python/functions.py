#functions in python

# defining a function
def my_function():
  print("Hello from a function")
my_function()

# passing arguments to a function
def my_function(fname):
  print(fname + " Refsnes")

my_function("Emil")
my_function("Tobias")
my_function("Linus")

# default parameter value
def my_function(country = "Norway"):
    print("I am from " + country)

my_function("Sweden")
my_function("Pakistan")
my_function()

# return values
def my_function(x):
  return 5 * x

print(my_function(3))
print(my_function(5))
print(my_function(9))


# passing a list as an argument
def my_function(food):
  for x in food:
    print(x)

fruits = ["apple", "banana", "cherry"]
my_function(fruits)

# return a list
def my_function(food):
  for x in food:
    print(x)
    return food

fruits = ["apple", "banana", "cherry"]
x = my_function(fruits)
print(x)

# passing a dictionary as an argument
def my_function(country = "Norway"):
  print("I am from " + country)

my_function("Sweden")
my_function("India")

# passing a dictionary as an argument
def my_function(**kid):
  print("His last name is " + kid["lname"])
  print("His first name is " + kid["fname"])
  my_function(fname = "Tobias", lname = "Refsnes")


  #set default parameter value
def my_function(food = "pizza"):
    print("I like " + food)

my_function("chocolate")
my_function("apple")
my_function()

# set and get function

def my_function(x):
    return 5 * x

print(my_function(3))

print(my_function(5))


