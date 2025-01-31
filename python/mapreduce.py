r1 = [1,2,3,4,5,6,7]

def mapreduce(r1):
    mapped_data = []

    for a in r1:
        mapped_data.append({a: 'r1'})

    return mapped_data

print(mapreduce(r1))


