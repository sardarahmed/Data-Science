

#SELECT a, b FROM r1 WHERE b > 3 AND c > 5, i need to solve this map only job
def emit(value):
    print(value)

def map(key, row):
    if row.relation == 'r1':
        if row.b > 3 and row.c > 5:
            print("value: " + str((row.a, row.b)))