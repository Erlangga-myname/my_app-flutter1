//memasukan package yang dibutuhkan oleh aplikasi
import 'package:english_words/english_words.dart';//paket bahasa inggris
import 'package:flutter/material.dart';//paket untuk tampilan UI (material UI)
import 'package:provider/provider.dart';//paket untuk interaksi aplikasi

//fungsi main (fungsi utama)
void main() {
  runApp(MyApp());//meamnggil fungsi runApp (yang menjalankan keseluruhan aplikasi di dalam myApp())
}

//membuat abstrak aplikasi dari statelessWidget (template apikasi bernama myApp)
class MyApp extends StatelessWidget {
  const MyApp({super.key});//menunjukan bahwa aplikasi ini akan tetap, tidak berubah setlah di-build

  @override//mengganti niali lama yang sudah ada di template, dengan nilai nilai yang baru (replace / overwrite)
  Widget build(BuildContext context) {//fungsi build adalah fungsi yang membanggun UI (mengatur posisi widget, dst)
  //ChangeNotifierProvider mendengarkan/mendeteksi semua interaksi yang terjadi di aplikasi
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),//membuat satu state bernama myAppState
      child: MaterialApp(//pada state ini, menggunakan style desain MateralUI
        title: 'Namer App',//diberi judul Namer App
        theme: ThemeData(//data tema aplikasi, diberi warna deepOrange
          useMaterial3: true,//versi materialUI yang dipakai versi 3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),//nama halaman "myHomePage" pada "myAppState"
      ),
    );
  }
}

//medefinisikan myAppState
class MyAppState extends ChangeNotifier {
  //state myAppState diisi dengan 2 kata random tsb disimpan di variable WordPair
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
}
}

// ...

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;               
    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          BigCard(pair: pair),                
          ElevatedButton(
            onPressed: () {
              appState.getNext();
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
     final theme = Theme.of(context);
final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
       child: Text(pair.asLowerCase, style: style),
      ),
    );
  }
}



// ...