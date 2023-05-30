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

    def freeze(self, x):
        # 0 - t1 = 1
        # t1 -t2 = down
        if x < self.t1:
            return 1
        elif self.t1 <= x <= self.t2:
            self.min = self.t1
            self.max = self.t2
            return self.down(x)
        else:
            return 0
    def cold(self, x):
        # t1 -t2 = up
        # t2 -t3 = down
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
        # t2 -t3 = up
        # t3 -t4 = down
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
        # t3 -t4 = up
        # t4 - ... = 1
        if self.t3 <= x <= self.t4:
            self.min = self.t3
            self.max = self.t4
            return self.up(x)
        elif x > self.t4:
            return 1
        else:
            return 0