from matplotlib import pyplot as plt


class BaseFuzzy():

    def __init__(self):
        self.minimum = 0
        self.maximum = 0

    def down(self, x):
        return (self.maximum - x) / (self.maximum - self.minimum)

    def up(self, x):
        return (x - self.minimum) / (self.maximum - self.minimum)


class Pressure(BaseFuzzy):

    def __init__(self):
        super().__init__()  # Initialize base class
        self.p1 = 5
        self.p2 = 10
        self.p3 = 15
        self.p4 = 20
        self.p5 = 23
        self.p6 = 27
        self.p7 = 32
        self.p8 = 37
        self.p9 = 40
        self.pn = 45

    def verylow(self, x):
        if x < self.p1:
            return 1
        elif self.p1 <= x <= self.p3:
            self.minimum = self.p1
            self.maximum = self.p3
            return self.down(x)
        else:
            return 0

    def low(self, x):
        if self.p2 <= x <= self.p3:
            self.minimum = self.p2
            self.maximum = self.p3
            return self.up(x)
        if self.p3 <= x <= self.p4:
            self.minimum = self.p3
            self.maximum = self.p4
            return self.down(x)
        else:
            return 0

    def medium(self, x):
        if self.p3 <= x <= self.p5:
            self.minimum = self.p3
            self.maximum = self.p5
            return self.up(x)
        if self.p5 <= x <= self.p6:
            return 1
        if self.p6 <= x <= self.p7:
            self.minimum = self.p6
            self.maximum = self.p7
            return self.down(x)
        else:
            return 0

    def high(self, x):
        if self.p6 <= x <= self.p7:
            self.minimum = self.p6
            self.maximum = self.p7
            return self.up(x)
        if self.p7 <= x <= self.p9:
            self.minimum = self.p7
            self.maximum = self.p9
            return self.down(x)
        else:
            return 0

    def veryhigh(self, x):
        if self.p8 <= x <= self.p9:
            self.minimum = self.p8
            self.maximum = self.p9
            return self.up(x)
        elif x > self.p9:
            return 1
        else:
            return 0

    def graph(self, value=None):
        plt.figure(figsize=(15, 10))
        x_range = [0, self.pn]
        # very low
        y_verylow = [1, 1]
        plt.plot([self.p1, self.p3], y_verylow, label='very low')
        # low
        y_low = [0, 1, 0]
        plt.plot([self.p2, self.p3, self.p4], y_low, label='low')
        # medium
        y_medium = [0, 1, 1, 0]
        plt.plot([self.p3, self.p5, self.p6, self.p7], y_medium, label='medium')
        # high
        y_high = [0, 1, 0]
        plt.plot([self.p6, self.p7, self.p9], y_high, label='high')
        # very high
        y_veryhigh = [0, 0, 1]
        plt.plot([self.p8, self.p9, self.pn], y_veryhigh, label='very high')

        if value is not None:
            value_verylow = self.verylow(value)
            value_low = self.low(value)
            value_medium = self.medium(value)
            value_high = self.high(value)
            value_veryhigh = self.veryhigh(value)
            x_param = [value, value, value]
            # very low
            y_verylowvalue = [value_verylow, 0, 0]
            plt.plot(x_param, y_verylowvalue, label='very low value')
            # low
            y_lowvalue = [0, value_low, 0]
            plt.plot(x_param, y_lowvalue, label='low value')
            # medium
            y_mediumvalue = [0, value_medium, 0]
            plt.plot(x_param, y_mediumvalue, label='medium value')
            # high
            y_highvalue = [0, value_high, 0]
            plt.plot(x_param, y_highvalue, label='high value')
            # very high
            y_veryhighvalue = [0, value_veryhigh, value_veryhigh]
            plt.plot(x_param, y_veryhighvalue, label='very high value')

        plt.xlabel('Pressure')
        plt.ylabel('Membership')
        plt.legend(loc='upper right')
        plt.show()


pressure = Pressure()
x = 0
print('very low:', pressure.verylow(x))
print('low:', pressure.low(x))
print('medium:', pressure.medium(x))
print('high:', pressure.high(x))
print('very high:', pressure.veryhigh(x))

pressure.graph(x)
