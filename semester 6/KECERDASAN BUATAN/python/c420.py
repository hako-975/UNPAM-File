from matplotlib import pyplot as plt


class BaseFuzzy():
    def __init__(self):
        self.max = 0
        self.min = 0

    def up(self, x):
        return (x - self.min) / (self.max - self.min)

    def down(self, x):
        return (self.max - x) / (self.max - self.min)


class Temp(BaseFuzzy):
    def __init__(self):
        self.t1 = 5
        self.t2 = 15
        self.t3 = 25
        self.t4 = 55
        self.tn = 60

    def freeze(self, x):
        # 0-t1 = 1
        # t1-t2 = down
        if x < self.t1:
            return 1
        elif self.t1 <= x <= self.t2:
            self.min = self.t1
            self.max = self.t2
            return self.down(x)
        else:
            return 0

    def cold(self, x):
        # t1-t2 = up
        # t2-t3 = down
        if self.t1 <= x <= self.t2:
            self.min = self.t1
            self.max = self.t2
            return self.up(x)
        elif self.t2 <= x <= self.t3:
            self.min = self.t2
            self.max = self.t3
            return self.down(x)
        else:
            return 0

    def warm(self, x):
        # t2-t3 = up
        # t3-t4 = down
        if self.t2 <= x <= self.t3:
            self.min = self.t2
            self.max = self.t3
            return self.up(x)
        elif self.t3 <= x <= self.t4:
            self.min = self.t3
            self.max = self.t4
            return self.down(x)
        else:
            return 0

    def hot(self, x):
        # t3-t4 = up
        # t4-... = 1
        if self.t3 <= x <= self.t4:
            self.min = self.t3
            self.max = self.t4
            return self.up(x)
        elif x > self.t4:
            return 1
        else:
            return 0

    def graph(self, value=None):
        # freeze
        # 0-t1 = 1 [1, 1]
        # t1-t2 = down [1, 0]
        # t2 -tn = 0 [0, 0]
        x_freeze = [0, self.t1, self.t2]
        y_freeze = [1, 1, 0]
        freeze_value = self.freeze(value)
        y_freeze_v = [freeze_value, freeze_value, 0]
        plt.plot(x_param, y_freeze_v, label=('v_freeze[{freeze_value}]'))

        plt.plot(x_freeze, y_freeze, label='freeze')

        # cold
        # t1-t2 = up
        # t2-t3 = down

        # warm
        # t2-t3 = up
        # t3-t4 = down

        # hot
        # t3-t4 = up
        # t4-... = 1
        plt.legend(loc='upper right')
        plt.show()


temp = Temp()

x = 22

print('freeze', temp.freeze(x))
print('cold', temp.cold(x))
print('warm', temp.warm(x))
print('hot', temp.hot(x))

temp.graph()
