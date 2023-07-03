from matplotlib import pyplot as plt


class BaseFuzzy():
    def __init__(self):
        self.maximum = 0
        self.minimum = 0

    def up(self, x):
        return (x - self.minimum) / (self.maximum - self.minimum)

    def down(self, x):
        return (self.maximum - x) / (self.maximum - self.minimum)


class Temperature(BaseFuzzy):
    def __init__(self):
        self.p1 = 20
        self.p2 = 30
        self.pn = 40

    def cold(self, x):
        if x >= self.p2:
            return 0
        elif x <= self.p1:
            return 1
        else:
            self.maximum = self.p2
            self.minimum = self.p1
            return self.down(x)

    def hot(self, x):
        if x >= self.p2:
            return 1
        elif x <= self.p1:
            return 0
        else:
            self.maximum = self.p2
            self.minimum = self.p1
            return self.up(x)

    def graph(self, ax, value=None):
        x = [0, self.p1, self.p2, self.pn]
        y_cold = [1, 1, 0, 0]
        ax.plot(x, y_cold, label='cold')
        y_hot = [0, 0, 1, 1]
        ax.plot(x, y_hot, label='hot')
        ax.set_title('Temperature')
        ax.legend(loc='upper left')
        if value:
            x_param = [0, value, value]
            cold_value = self.cold(value)
            y_param_cold = [cold_value, cold_value, 0]
            ax.plot(x_param, y_param_cold, color='C0')
            hot_value = self.hot(value)
            y_param_hot = [hot_value, hot_value, 0]
            ax.plot(x_param, y_param_hot, color='C1')


class Pressure(BaseFuzzy):
    def __init__(self):
        self.p1 = 50
        self.p2 = 70
        self.pn = 80

    def low(self, x):
        if x >= self.p2:
            return 0
        elif x <= self.p1:
            return 1
        else:
            self.maximum = self.p2
            self.minimum = self.p1
            return self.down(x)

    def high(self, x):
        if x >= self.p2:
            return 1
        elif x <= self.p1:
            return 0
        else:
            self.maximum = self.p2
            self.minimum = self.p1
            return self.up(x)

    def graph(self, ax, value=None):
        x = [0, self.p1, self.p2, self.pn]
        y_low = [1, 1, 0, 0]
        ax.plot(x, y_low, label='low', color='C0')
        y_high = [0, 0, 1, 1]
        ax.plot(x, y_high, label='high', color='C1')
        ax.legend(loc='upper left')
        ax.set_title('Pressure')
        if value:
            x_param = [0, value, value]
            low_value = self.low(value)
            y_param_low = [low_value, low_value, 0]
            ax.plot(x_param, y_param_low, color='C0')
            high_value = self.high(value)
            y_param_high = [high_value, high_value, 0]
            ax.plot(x_param, y_param_high, color='C1')


class Speed(BaseFuzzy):
    minimum = 1000
    maximum = 5000
    temperature = 0
    pressure = 0

    def __init__(self):
        self.p1 = 1000
        self.p2 = 5000
        self.pn = 6000
        self.temperature = 0
        self.pressure = 0
        self.decrease = 0
        self.increase = 0
        self.real_value = 0

    def _decrease(self, a):
        self.decrease = self.p2 - a * (self.p2 - self.p1)
        return self.decrease

    def _increase(self, a):
        self.increase = a * (self.p2 - self.p1) + self.p1
        return self.increase

    @property
    def fuzzy_decrease(self):
        x = self.real_value
        if x >= self.p2:
            return 0
        elif x <= self.p1:
            return 1
        else:
            self.minimum = self.p1
            self.maximum = self.p2
            return self.down(x)

    @property
    def fuzzy_increase(self):
        x = self.real_value
        if x >= self.p2:
            return 1
        elif x <= self.p1:
            return 0
        else:
            self.minimum = self.p1
            self.maximum = self.p2
            return self.up(x)

    def _inference(self, temp=Temperature(), press=Pressure()):
        result = []
        a1 = min(temp.cold(self.temperature), press.low(self.pressure))
        z1 = self._decrease(a1)
        result.append((a1, z1))
        a2 = min(temp.cold(self.temperature), press.high(self.pressure))
        z2 = self._decrease(a2)
        result.append((a2, z2))
        a3 = min(temp.hot(self.temperature), press.low(self.pressure))
        z3 = self._increase(a3)
        result.append((a3, z3))
        a4 = min(temp.hot(self.temperature), press.high(self.pressure))
        z4 = self._increase(a4)
        result.append((a4, z4))
        return result

    def defuzzification(self, inference_data=[]):
        inference_data = inference_data if inference_data else self._inference()
        res_a_z = 0
        res_a = 0
        for data in inference_data:
            res_a_z += data[0] * data[1]
            res_a += data[0]
        self.real_value = res_a_z / res_a
        return self.real_value

    def graph(self):
        fig, ((ax1, ax2), (ax3, ax4)) = plt.subplots(2, 2)
        temp = Temperature()
        press = Pressure()

        temp.graph(ax1, self.temperature)
        press.graph(ax2, self.pressure)

        x = [0, self.p1, self.p2, self.pn]
        y_decrease = [1, 1, 0, 0]
        ax3.plot(x, y_decrease, label='decrease', color='C0')
        y_increase = [0, 0, 1, 1]
        ax3.plot(x, y_increase, label='increase', color='C1')
        ax3.set_title('Speed [Output]')
        ax3.legend(loc='upper left')
        if self.real_value:
            value = self.real_value
            x_param = [0, value, value]
            decrease_value = self.fuzzy_decrease
            y_param_decrease = [decrease_value, decrease_value, 0]
            ax3.plot(x_param, y_param_decrease, color='C0')
            increase_value = self.fuzzy_increase
            y_param_increase = [increase_value, increase_value, 0]
            ax3.plot(x_param, y_param_increase, color='C1')

        plt.show()


temperature = input('Temperature:')
pressure = input('Pressure:')
speed = Speed()

speed.temperature = float(temperature)
speed.pressure = float(pressure)
speed_result = speed.defuzzification()

print(f'Speed result: {speed_result}')

speed.graph()
