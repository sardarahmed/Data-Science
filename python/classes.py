#blue print for class onject
class Car:
    def __init__(self, brand, model):
        self.brand = brand
        self.model = model

#object
my_car = Car("Toyota","Corolla")
print(my_car.brand)

class student:
    def __init__(self):
        pass
    def intro(self, name, course):
        self.name = name
        self.course = course
info = student()
info.intro("Ahmed", "DS")
print(f"my name is {info.name} and I am enrolled in master in {info.course}")