FTGCircularTuner
=========
Simple tuner

![FTGCircularTuner](http://i61.tinypic.com/29ek50h.png)


How to use it
--
Import `FTGValidator.h` and you're good to go

```

- (void)viewDidLoad {
    [super viewDidLoad];

    FTGCircularTuner *tuner = [[FTGCircularTuner alloc] init];
    tuner.incompleteColor = [UIColor grayColor];
    tuner.image = [UIImage imageNamed:@"volume"];

    [tuner addTarget:self action:@selector(tunerDidBeginInteraction:) forControlEvents:UIControlEventEditingDidBegin];
    [tuner addTarget:self action:@selector(tunerDidEndInteraction:) forControlEvents:UIControlEventEditingDidEnd];
    [tuner addTarget:self action:@selector(tunerProgressChanged:) forControlEvents:UIControlEventValueChanged];

    self.tuner = tuner;
    [self.view addSubview:tuner];
}

- (void)tunerDidBeginInteraction:(id)sender {
    NSLog(@"begin");
}

- (void)tunerDidEndInteraction:(id)sender {
    NSLog(@"end");
}

- (void)tunerProgressChanged:(FTGCircularTuner *)tuner {
    NSLog(@"progress %f", tuner.progress);
}

```


License
--
This project is released under the MIT license. See LICENSE.md