import 'package:flutter/material.dart';
import 'package:jernl/blocs/journal_edit_bloc.dart';
import 'package:jernl/models/journal.dart';

class JournalEditBlocProvider extends InheritedWidget {
  final JournalEditBloc journalEditBloc;
  final bool add;
  final Journal journal;

  const JournalEditBlocProvider(
      {Key key, Widget child, this.journalEditBloc, this.add, this.journal})
      : super(key: key, child: child);

  static JournalEditBlocProvider of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(JournalEditBlocProvider) as JournalEditBlocProvider);
  }

  @override
  bool updateShouldNotify(JournalEditBlocProvider old) => journalEditBloc != old.journalEditBloc;
}
