


import numpy as np
import random





sequence = np.array([1, 0, 1, 0])




#data = [random.choice((0, 1)) for _ in range(1000)]

data = np.random.choice((0, 1), 1000)

print(f"{data=}")



def get_indicies():

    indicies = list()

    for n in range(len(data) - len(sequence) + 1):
        view = data[n : n + len(sequence)]

        if (view == sequence).all():
            indicies.append(n)

    return indicies



indicies = get_indicies()




class StateMachine:

    def __init__(self):



breakpoint()




