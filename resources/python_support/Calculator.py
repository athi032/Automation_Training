class BasicCalculator:
    
    def add(self, number_1, number_2):
        return float(number_1) + float(number_2)
    
    def kwargs_demo_1(self, *kwargs):
        for args in kwargs:
            if args == 'apple':
                return True
        return False
    
    def kwargs_demo_2(self, **kwargs):
        if 'fruit' in kwargs.keys():
            if kwargs['fruit'] == 'mango':
                return True
        else:
            return False
    
cal = BasicCalculator()