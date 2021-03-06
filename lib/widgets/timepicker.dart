import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// For changing the language
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_cupertino_localizations/flutter_cupertino_localizations.dart';


const appName = 'DateTimeField Example';

void main() => runApp(MaterialApp(
  title: appName,
  home: TimeHomePage(),
  theme: ThemeData.light().copyWith(
      inputDecorationTheme:
      InputDecorationTheme(border: OutlineInputBorder())),
  localizationsDelegates: [
    // ... app-specific localization delegate[s] here
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: [
    const Locale('en'), // English
    const Locale('es'), // Spanish
    const Locale('fr'), // French
    const Locale('zh'), // Chinese
  ],
));

class TimeHomePage extends StatefulWidget {
  @override
  TimeHomePageState createState() => TimeHomePageState();
}

class TimeHomePageState extends State<TimeHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(appName)),
        body: ListView(
          padding: EdgeInsets.all(24),
          children: <Widget>[
            DateTimeForm(),
          ],
        ));
  }
}

class DateTimeForm extends StatefulWidget {
  @override
  _DateTimeFormState createState() => _DateTimeFormState();
}

class _DateTimeFormState extends State<DateTimeForm> {
  final formKey = GlobalKey<FormState>();
  DateTime _dateTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          BasicDateField(),
          SizedBox(height: 24),
          BasicTimeField(),
          SizedBox(height: 24),
          Clock24Example(),
          SizedBox(height: 24),
          LocaleExample(),
          SizedBox(height: 24),
          BasicDateTimeField(

          ),
          SizedBox(height: 24),
          ComplexDateTimeField(),
          SizedBox(height: 24),
          RaisedButton(
            child: Text('Save'),
            onPressed: () => formKey.currentState.save(),
          ),
          RaisedButton(
            child: Text('Reset'),
            onPressed: () => formKey.currentState.reset(),
          ),
          RaisedButton(
            child: Text('Validate'),
            onPressed: () => formKey.currentState.validate(),
          ),
        ],
      ),
    );
  }
}

class BasicDateField extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic date field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) {
          return showRoundedDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              borderRadius: 20
          );
        }
//        onShowPicker: (context, currentValue) {
//          return showDatePicker(
//              context: context,
//              helpText: "Howdy choose",
//              firstDate: DateTime(1900),
//              initialDate: currentValue ?? DateTime.now(),
//              lastDate: DateTime(2100));
//        },
      ),
    ]);
  }
}

class BasicTimeField extends StatefulWidget{

  final TextEditingController controller;
  @override
  BasicTimeField({@required this.controller});

  @override
  BasicTimeFieldState createState() => BasicTimeFieldState();

}
class BasicTimeFieldState extends State<BasicTimeField> {
  final format = DateFormat("hh:mm a");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Basic time field (${format.pattern})'),
      DateTimeField(
        controller: widget.controller,
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}


class BasicDateTimeField extends StatefulWidget{
  final TextEditingController controller;
  BasicDateTimeField({@required this.controller});
  @override
  BasicDateTimeFieldState createState() => BasicDateTimeFieldState();
}
class BasicDateTimeFieldState extends State<BasicDateTimeField> {

  final format = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      DateTimeField(
        decoration: InputDecoration(
          labelText: "Enter due date and time if exists."
        ),
        controller: widget.controller,
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showRoundedDatePicker(
              initialDatePickerMode: DatePickerMode.day,
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100),
              borderRadius: 16,
              theme: ThemeData(primarySwatch: Colors.blue),
              styleDatePicker: MaterialRoundedDatePickerStyle(
                textStyleDayButton: TextStyle(fontSize: 30, color: Colors.white),
                textStyleYearButton: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                ),
                textStyleDayHeader: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textStyleCurrentDayOnCalendar:
                TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                textStyleDayOnCalendar: TextStyle(fontSize: 20, color: Colors.white),
                textStyleDayOnCalendarSelected:
                TextStyle(fontSize: 20, color: Colors.lightBlueAccent, fontWeight: FontWeight.bold),
                textStyleDayOnCalendarDisabled: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.1)),
                textStyleMonthYearHeader:
                TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
                paddingDatePicker: EdgeInsets.all(0),
                paddingMonthHeader: EdgeInsets.all(20),
                paddingActionBar: EdgeInsets.all(16),
                paddingDateYearHeader: EdgeInsets.all(20),
                sizeArrow: 30,
                colorArrowNext: Colors.white,
                colorArrowPrevious: Colors.white,
                marginLeftArrowPrevious: 10,
                marginTopArrowPrevious: 10,
                marginTopArrowNext: 10,
                marginRightArrowNext: 10,
                textStyleButtonAction: TextStyle(fontSize: 20, color: Colors.white),
                textStyleButtonPositive:
                TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                textStyleButtonNegative: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.5)),
                decorationDateSelected: BoxDecoration(color: Colors.yellowAccent, shape: BoxShape.circle),
                backgroundPicker: Colors.lightBlueAccent,
                backgroundActionBar: Colors.lightBlueAccent,
                backgroundHeaderMonth: Colors.lightBlueAccent,
              ),
              styleYearPicker: MaterialRoundedYearPickerStyle(
                textStyleYear: TextStyle(fontSize: 40, color: Colors.white),
                textStyleYearSelected:
                TextStyle(fontSize: 56, color: Colors.white, fontWeight: FontWeight.bold),
                heightYearRow: 100,
                backgroundPicker: Colors.lightBlueAccent,
              )
          );
//          final date = await showDatePicker(
//              context: context,
//              firstDate: DateTime(1900),
//              initialDate: currentValue ?? DateTime.now(),
//              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showRoundedTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                theme: ThemeData(primarySwatch: Colors.blue),
            );
//            final time = await showTimePicker(
//              context: context,
//              initialTime:
//              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}

class IosStylePickers extends StatefulWidget {
  @override
  _IosStylePickersState createState() => _IosStylePickersState();
}

class _IosStylePickersState extends State<IosStylePickers> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  DateTime value;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('iOS style pickers (${format.pattern})'),
      DateTimeField(
        initialValue: value,
        format: format,
        onShowPicker: (context, currentValue) async {
          await showCupertinoModalPopup(
              context: context,
              builder: (context) {
                return CupertinoDatePicker(
                  onDateTimeChanged: (DateTime date) {
                    value = date;
                  },
                );
              });
          setState(() {});
          return value;
        },
      ),
    ]);
  }
}

class ComplexDateTimeField extends StatefulWidget {
  @override
  _ComplexDateTimeFieldState createState() => _ComplexDateTimeFieldState();
}

class _ComplexDateTimeFieldState extends State<ComplexDateTimeField> {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  final initialValue = DateTime.now();

  bool autoValidate = false;
  bool readOnly = true;
  bool showResetIcon = true;
  DateTime value = DateTime.now();
  int changedCount = 0;
  int savedCount = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Complex date & time field (${format.pattern})'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              initialDate: currentValue ?? DateTime.now(),
              lastDate: DateTime(2100));
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
        autovalidate: autoValidate,
        validator: (date) => date == null ? 'Invalid date' : null,
        initialValue: initialValue,
        onChanged: (date) => setState(() {
          value = date;
          changedCount++;
        }),
        onSaved: (date) => setState(() {
          value = date;
          savedCount++;
        }),
        resetIcon: showResetIcon ? Icon(Icons.delete) : null,
        readOnly: readOnly,
        decoration: InputDecoration(
            helperText: 'Changed: $changedCount, Saved: $savedCount, $value'),
      ),
      CheckboxListTile(
        title: Text('autoValidate'),
        value: autoValidate,
        onChanged: (value) => setState(() => autoValidate = value),
      ),
      CheckboxListTile(
        title: Text('readOnly'),
        value: readOnly,
        onChanged: (value) => setState(() => readOnly = value),
      ),
      CheckboxListTile(
        title: Text('showResetIcon'),
        value: showResetIcon,
        onChanged: (value) => setState(() => showResetIcon = value),
      ),
    ]);
  }
}

class Clock24Example extends StatelessWidget {
  final format = DateFormat("HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('24 hour clock'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
            builder: (context, child) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: child),
          );
          return DateTimeField.convert(time);
        },
      ),
    ]);
  }
}

class LocaleExample extends StatelessWidget {
  final format = DateFormat("yyyy-MM-dd HH:mm");
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Text('Changing the pickers\' language'),
      DateTimeField(
        format: format,
        onShowPicker: (context, currentValue) async {
          final date = await showDatePicker(
            context: context,
            firstDate: DateTime(1900),
            initialDate: DateTime.now(),
            lastDate: DateTime(2100),
            builder: (context, child) => Localizations.override(
              context: context,
              locale: Locale('zh'),
              child: child,
            ),
          );
          if (date != null) {
            final time = await showTimePicker(
              context: context,
              initialTime:
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              builder: (context, child) => Localizations.override(
                context: context,
                locale: Locale('zh'),
                child: child,
              ),
            );
            return DateTimeField.combine(date, time);
          } else {
            return currentValue;
          }
        },
      ),
    ]);
  }
}