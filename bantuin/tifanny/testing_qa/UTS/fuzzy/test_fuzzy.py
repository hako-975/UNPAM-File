import unittest
from fuzzy import Temp

class TestTempFreezeMethod(unittest.TestCase):
    def test_freeze_below_t1(self):
        temp = Temp()
        temp.t1 = 20
        result = temp.freeze(15)
        self.assertEqual(result, 1, "Value below t1 should return 1")

    def test_freeze_between_t1_and_t2(self):
        temp = Temp()
        temp.t1 = 20
        temp.t2 = 40
        result = temp.freeze(30)
        self.assertEqual(result, temp.down(30), "Value between t1 and t2 should return down(x)")

    def test_freeze_above_t2(self):
        temp = Temp()
        temp.t1 = 20
        temp.t2 = 40
        result = temp.freeze(50)
        self.assertEqual(result, 0, "Value above t2 should return 0")

if __name__ == '__main__':
    unittest.main()
