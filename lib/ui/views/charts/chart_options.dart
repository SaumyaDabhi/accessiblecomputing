class SelectOption {
  final int id;
  final String name;

  SelectOption({
    this.id,
    this.name,
  });

  static final List<List<SelectOption>> selectOptionsBarGraph = [
    [
      SelectOption(id: 0, name: "Jan"),
      SelectOption(id: 1, name: "Feb"),
      SelectOption(id: 2, name: "Mar"),
      SelectOption(id: 3, name: "Apr"),
      SelectOption(id: 4, name: "May"),
      SelectOption(id: 5, name: "Jun"),
      SelectOption(id: 6, name: "Jul"),
      SelectOption(id: 7, name: "Aug"),
      SelectOption(id: 8, name: "Sep"),
      SelectOption(id: 9, name: "Oct"),
      SelectOption(id: 10, name: "Nov"),
      SelectOption(id: 11, name: "Dec")
    ],
    [
      SelectOption(id: 0, name: "Mon"),
      SelectOption(id: 1, name: "Tue"),
      SelectOption(id: 2, name: "Wed"),
      SelectOption(id: 3, name: "Thu"),
      SelectOption(id: 4, name: "Fri"),
      SelectOption(id: 5, name: "Sat"),
      SelectOption(id: 6, name: "Sun")
    ],
    [
      SelectOption(id: 0, name: "Prod A"),
      SelectOption(id: 1, name: "Prod B"),
      SelectOption(id: 2, name: "Prod C"),
      SelectOption(id: 3, name: "Prod D"),
      SelectOption(id: 4, name: "Prod E"),
      SelectOption(id: 5, name: "Prod F"),
      SelectOption(id: 6, name: "Prod G"),
      SelectOption(id: 7, name: "Prod H"),
      SelectOption(id: 8, name: "Prod I"),
      SelectOption(id: 9, name: "Prod J"),
      SelectOption(id: 10, name: "Prod K"),
      SelectOption(id: 11, name: "Prod L")
    ],
    [
      SelectOption(id: 0, name: "NSE 1"),
      SelectOption(id: 1, name: "NSE 2"),
      SelectOption(id: 2, name: "NSE 3"),
      SelectOption(id: 3, name: "NSE 4"),
      SelectOption(id: 4, name: "NSE 5"),
      SelectOption(id: 5, name: "NSE 6"),
      SelectOption(id: 6, name: "NSE 7"),
      SelectOption(id: 7, name: "NSE 8"),
      SelectOption(id: 8, name: "NSE 9"),
      SelectOption(id: 9, name: "NSE 10")
    ]
  ];

  static final List<List<SelectOption>> selectOptionsLineGraph = [
    [
      SelectOption(id: 0, name: "2010"),
      SelectOption(id: 1, name: "2011"),
      SelectOption(id: 2, name: "2012"),
      SelectOption(id: 3, name: "2013"),
      SelectOption(id: 4, name: "2014"),
      SelectOption(id: 5, name: "2015"),
      SelectOption(id: 6, name: "2016"),
      SelectOption(id: 7, name: "2017"),
      SelectOption(id: 8, name: "2018"),
      SelectOption(id: 9, name: "2019"),
      SelectOption(id: 10, name: "2020"),
      SelectOption(id: 11, name: "2021")
    ],
    [
      SelectOption(id: 0, name: "Week 1"),
      SelectOption(id: 1, name: "Week 2"),
      SelectOption(id: 2, name: "Week 3"),
      SelectOption(id: 3, name: "Week 4"),
      SelectOption(id: 4, name: "Week 5"),
      SelectOption(id: 5, name: "Week 6"),
      SelectOption(id: 6, name: "Week 7")
    ],
    [
      SelectOption(id: 0, name: "Jan"),
      SelectOption(id: 1, name: "Feb"),
      SelectOption(id: 2, name: "Mar"),
      SelectOption(id: 3, name: "Apr"),
      SelectOption(id: 4, name: "May"),
      SelectOption(id: 5, name: "Jun"),
      SelectOption(id: 6, name: "Jul"),
      SelectOption(id: 7, name: "Aug"),
      SelectOption(id: 8, name: "Sep"),
      SelectOption(id: 9, name: "Oct"),
      SelectOption(id: 10, name: "Nov"),
      SelectOption(id: 11, name: "Dec")
    ],
    [
      SelectOption(id: 0, name: "Qtr 1"),
      SelectOption(id: 1, name: "Qtr 2"),
      SelectOption(id: 2, name: "Qtr 3"),
      SelectOption(id: 3, name: "Qtr 4"),
      SelectOption(id: 4, name: "Qtr* 1"),
      SelectOption(id: 5, name: "Qtr* 2"),
      SelectOption(id: 6, name: "Qtr* 3"),
      SelectOption(id: 7, name: "Qtr* 4"),
      SelectOption(id: 8, name: "Qtr^ 1"),
      SelectOption(id: 9, name: "Qtr^ 2")
    ],
  ];

  static final List<SelectOption> pieSelectOptions = [
    SelectOption(id: 0, name: "Region A"),
    SelectOption(id: 1, name: "Region B"),
    SelectOption(id: 2, name: "Region C"),
    SelectOption(id: 3, name: "Region D")
  ];
}
