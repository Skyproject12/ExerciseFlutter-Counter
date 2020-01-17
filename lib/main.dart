import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Counter", 
      home: BlocProvider<CounterBloc>( 
        // defination bloc can use in the page  
        create: (context) => CounterBloc(),  
        // defination page can execution 
        child: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) { 
    // defination first in call the block 
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Counter'),), 
      body: BlocBuilder<CounterBloc, int>( 
        builder: (context, count){   
          // settext the value of text from Counter bloc 
          return Text( 
            "$count", style: TextStyle(fontSize: 24.0),
          );
        }
      ),
      // make floating action button with widget  
      floatingActionButton: Column( 
        crossAxisAlignment: CrossAxisAlignment.end, 
        mainAxisAlignment: MainAxisAlignment.end, 
        children: <Widget>[  
          Padding( 
            padding: EdgeInsets.symmetric(vertical: 5.0), 
            child: FloatingActionButton( 
              child: Icon(Icons.add), 
              onPressed: (){ 
                // ketika floationg action button di klik maka akan memanggil CounterEvent.increment   
                counterBloc.add(CounterEvent.increment);
              },
            ),
          ), 
          Padding( 
            padding: EdgeInsets.symmetric(vertical: 5.0), 
            child: FloatingActionButton( 
              child: Icon(Icons.remove), 
              onPressed: (){ 
                counterBloc.add(CounterEvent.decrement);
              },
            ),
          )
        ],
      ),
    );
  }
}

enum CounterEvent{ 
  increment, decrement
}  
// defination event bloc
class CounterBloc extends Bloc<CounterEvent, int>{
  @override
  // TODO: implement initialState
  int get initialState => 0;

// make return int 
  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    // TODO: implement mapEventToState 
    switch(event){  
      case CounterEvent.decrement: 
      // return result when min 
        yield state -1; 
      break; 
      case CounterEvent.increment: 
      yield state +1; 
      break;
    }
  } 
  
}