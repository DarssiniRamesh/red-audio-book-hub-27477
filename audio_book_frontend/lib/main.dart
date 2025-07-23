import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';

// PUBLIC_INTERFACE
void main() {
  runApp(const AudioBookApp());
}

/// PUBLIC_INTERFACE
/// Main app widget for the Audio Book Frontend.
class AudioBookApp extends StatelessWidget {
  const AudioBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookProvider>(
      create: (_) => BookProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Red Audio Book Hub',
        theme: ThemeData(
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFB71C1C),
            secondary: Color(0xFFD32F2F),
            tertiary: Color(0xFFFF5252),
            surface: Color(0xFFFDEAEA),
            // background: Color(0xFFFDEAEA), -- removed as 'background' is deprecated
            onPrimary: Colors.white,
            onSecondary: Colors.white,
            onTertiary: Colors.white,
          ),
          fontFamily: 'Roboto',
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFB71C1C),
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22,
              letterSpacing: 0.5,
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFD32F2F),
            foregroundColor: Colors.white,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Color(0xFFFDEAEA),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFB71C1C)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD32F2F), width: 2.0),
            ),
            labelStyle: TextStyle(color: Color(0xFFD32F2F)),
          ),
        ),
        home: const BookListScreen(),
      ),
    );
  }
}

//#region --- Models ---
class AudioBook {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String audioUrl;
  final String description;
  final int durationSeconds;
  final DateTime releaseDate;

  AudioBook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.audioUrl,
    required this.description,
    required this.durationSeconds,
    required this.releaseDate,
  });
}
//#endregion

//#region --- Book Data ---
List<AudioBook> demoBooks = [
  AudioBook(
    id: "1",
    title: "Red Rising",
    author: "Pierce Brown",
    coverUrl: "https://covers.openlibrary.org/b/id/8759139-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
    description: "Darrow is a Red, a member of the lowest caste in the color-coded society of the future. He discovers the world above and leads a revolution.",
    durationSeconds: 1494,
    releaseDate: DateTime(2014, 1, 28),
  ),
  AudioBook(
    id: "2",
    title: "Project Hail Mary",
    author: "Andy Weir",
    coverUrl: "https://covers.openlibrary.org/b/id/10543598-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
    description: "Ryland Grace is the sole survivor on a desperate, last-chance mission to save humanity and the earth.",
    durationSeconds: 1837,
    releaseDate: DateTime(2021, 5, 4),
  ),
  AudioBook(
    id: "3",
    title: "Station Eleven",
    author: "Emily St. John Mandel",
    coverUrl: "https://covers.openlibrary.org/b/id/8228699-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
    description: "An audacious, darkly glittering novel set in the eerie days of civilization’s collapse after a pandemic.",
    durationSeconds: 1520,
    releaseDate: DateTime(2014, 9, 9),
  ),
  AudioBook(
    id: "4",
    title: "Atomic Habits",
    author: "James Clear",
    coverUrl: "https://covers.openlibrary.org/b/id/9286674-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
    description: "Tiny Changes, Remarkable Results. The #1 New York Times bestseller on forming good habits and breaking bad ones.",
    durationSeconds: 1245,
    releaseDate: DateTime(2018, 10, 16),
  ),
  AudioBook(
    id: "5",
    title: "Educated",
    author: "Tara Westover",
    coverUrl: "https://covers.openlibrary.org/b/id/8947269-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3",
    description: "A memoir about a young girl who, kept out of school, leaves her survivalist family and goes on to earn a PhD.",
    durationSeconds: 1623,
    releaseDate: DateTime(2018, 2, 20),
  ),
  AudioBook(
    id: "6",
    title: "The Martian",
    author: "Andy Weir",
    coverUrl: "https://covers.openlibrary.org/b/id/8108694-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3",
    description: "Abandoned on Mars, Mark Watney must use his ingenuity and spirit to survive.",
    durationSeconds: 1394,
    releaseDate: DateTime(2011, 2, 11),
  ),
  AudioBook(
    id: "7",
    title: "Sapiens",
    author: "Yuval Noah Harari",
    coverUrl: "https://covers.openlibrary.org/b/id/10088426-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3",
    description: "A Brief History of Humankind, charting the course of evolution and civilization.",
    durationSeconds: 1751,
    releaseDate: DateTime(2015, 2, 10),
  ),
  AudioBook(
    id: "8",
    title: "The Silent Patient",
    author: "Alex Michaelides",
    coverUrl: "https://covers.openlibrary.org/b/id/9858398-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3",
    description: "A shocking psychological thriller of a woman’s act of violence against her husband—and of the therapist obsessed with uncovering her motive.",
    durationSeconds: 1588,
    releaseDate: DateTime(2019, 2, 5),
  ),
  AudioBook(
    id: "9",
    title: "Where the Crawdads Sing",
    author: "Delia Owens",
    coverUrl: "https://covers.openlibrary.org/b/id/10037763-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3",
    description: "Kya’s coming-of-age story in the wild marshes of North Carolina with a twist of mystery.",
    durationSeconds: 1687,
    releaseDate: DateTime(2018, 8, 14),
  ),
  AudioBook(
    id: "10",
    title: "Circe",
    author: "Madeline Miller",
    coverUrl: "https://covers.openlibrary.org/b/id/9415961-L.jpg",
    audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3",
    description: "A bold and subversive retelling of the goddess's story that manages to be both epic and intimate.",
    durationSeconds: 1548,
    releaseDate: DateTime(2018, 4, 10),
  ),
];
//#endregion

//#region --- State Management ---
class BookProvider extends ChangeNotifier {
  final List<AudioBook> _books = demoBooks;
  String _search = '';

  AudioBook? _currentBook;
  bool _isPlaying = false;

  // Used to persist last played book (book id) and play mode
  SharedPreferences? _prefs;

  BookProvider() {
    _init();
  }
  void _init() async {
    _prefs = await SharedPreferences.getInstance();
    _isPlaying = _prefs?.getBool('isPlaying') ?? false;
    String? bookId = _prefs?.getString('currentBookId');
    if (bookId != null) {
      _currentBook = _books.firstWhere((b) => b.id == bookId, orElse: () => _books[0]);
    }
    notifyListeners();
  }

  List<AudioBook> get books {
    if (_search.isEmpty) return _books;
    return _books
        .where((b) =>
            b.title.toLowerCase().contains(_search.toLowerCase()) ||
            b.author.toLowerCase().contains(_search.toLowerCase()))
        .toList();
  }

  String get search => _search;
  AudioBook? get currentBook => _currentBook;
  bool get isPlaying => _isPlaying;

  set search(String val) {
    _search = val;
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  void selectBook(AudioBook book) {
    _currentBook = book;
    _prefs?.setString('currentBookId', book.id);
    _isPlaying = false;
    _prefs?.setBool('isPlaying', false);
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  void play() {
    _isPlaying = true;
    _prefs?.setBool('isPlaying', true);
    notifyListeners();
  }

  // PUBLIC_INTERFACE
  void pause() {
    _isPlaying = false;
    _prefs?.setBool('isPlaying', false);
    notifyListeners();
  }
}
//#endregion

//#region --- Screens ---

/// PUBLIC_INTERFACE
/// Book Listing Screen: Shows search, grid of books, and bottom player.
class BookListScreen extends StatelessWidget {
  const BookListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);
    final books = provider.books;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Red Audio Book Hub'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          _AppSearchBar(
            onChanged: (val) => provider.search = val,
            value: provider.search,
          ),
          Expanded(
            child: books.isEmpty
                ? Center(
                    child: Text(
                      'No books found.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: GridView.builder(
                      itemCount: books.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.64,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                      ),
                      itemBuilder: (context, idx) {
                        final book = books[idx];
                        return GestureDetector(
                          onTap: () {
                            provider.selectBook(book);
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => BookDetailScreen(book: book)));
                          },
                          child: _BookGridCard(book: book),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
      bottomNavigationBar: const AudioPlayerBar(),
    );
  }
}

/// PUBLIC_INTERFACE
/// Book Detail/Player Screen: shows description, cover, and audio controls.
class BookDetailScreen extends StatelessWidget {
  final AudioBook book;

  const BookDetailScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    // final provider = Provider.of<BookProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Center(
            child: Hero(
              tag: 'cover_${book.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  book.coverUrl,
                  width: 180,
                  height: 260,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, _, __) =>
                      Container(width: 180, height: 260, color: Colors.grey[300]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            book.title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary),
          ),
          Text(
            "by ${book.author}",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Theme.of(context).colorScheme.secondary),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.timer, color: Theme.of(context).colorScheme.tertiary, size: 20),
              const SizedBox(width: 5),
              Text(_formatDuration(book.durationSeconds), style: const TextStyle(fontSize: 15)),
              const SizedBox(width: 15),
              Icon(Icons.calendar_today, color: Theme.of(context).colorScheme.tertiary, size: 18),
              const SizedBox(width: 4),
              Text(DateFormat('yMMMd').format(book.releaseDate), style: const TextStyle(fontSize: 15)),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            book.description,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
      bottomNavigationBar: const AudioPlayerBar(detailedScreen: true),
    );
  }
}
//#endregion

//#region --- Widgets ---

class _AppSearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String value;
  const _AppSearchBar({required this.onChanged, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextField(
        onChanged: onChanged,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          labelText: 'Search audiobooks',
          prefixIcon: const Icon(Icons.search, color: Color(0xFFD32F2F)),
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 18),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 2.0),
              borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }
}

class _BookGridCard extends StatelessWidget {
  final AudioBook book;
  const _BookGridCard({required this.book});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFDEAEA),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 4,
      shadowColor: Colors.redAccent.withAlpha((0.15 * 255).toInt()),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Hero(
            tag: 'cover_${book.id}',
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ),
              child: Image.network(
                book.coverUrl,
                height: 148,
                fit: BoxFit.cover,
                errorBuilder: (ctx, _, __) =>
                    Container(height: 148, color: Colors.grey[300]),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: Text(book.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
            child: Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 13, color: Theme.of(context).colorScheme.secondary, fontWeight: FontWeight.w500),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.timer, size: 17, color: Theme.of(context).colorScheme.tertiary),
                    const SizedBox(width: 2),
                    Text(_formatDuration(book.durationSeconds), style: const TextStyle(fontSize: 12)),
                  ],
                ),
                Icon(Icons.audiotrack, color: Theme.of(context).colorScheme.tertiary, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

 
//#region --- Audio Player Widget (UI & State) ---

/// PUBLIC_INTERFACE
/// Audio Player Bar widget for both book list and detail.
/// Shows basic controls & current book info. Manages its own player instance.
class AudioPlayerBar extends StatefulWidget {
  final bool detailedScreen; // when true, show larger controls

  const AudioPlayerBar({super.key, this.detailedScreen = false});

  @override
  State<AudioPlayerBar> createState() => _AudioPlayerBarState();
}

class _AudioPlayerBarState extends State<AudioPlayerBar> {
  late final AudioPlayer _audioPlayer;
  PlayerState _state = PlayerState.stopped;
  Duration _pos = Duration.zero;
  Duration _duration = const Duration(seconds: 1);

  AudioBook? _activeBook;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _audioPlayer.onPlayerStateChanged.listen((s) => setState(() => _state = s));
    _audioPlayer.onDurationChanged.listen((d) => setState(() => _duration = d));
    _audioPlayer.onPositionChanged.listen((p) => setState(() => _pos = p));
    _audioPlayer.onPlayerComplete.listen((_) {
      setState(() {
        _pos = _duration;
        Provider.of<BookProvider>(context, listen: false).pause();
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _play(AudioBook book) async {
    final provider = Provider.of<BookProvider>(context, listen: false);
    if (_activeBook == null || _activeBook!.id != book.id) {
      await _audioPlayer.stop();
      setState(() {
        _pos = Duration.zero;
        _duration = Duration(seconds: book.durationSeconds);
        _activeBook = book;
      });
    }
    await _audioPlayer.play(UrlSource(book.audioUrl));
    provider.play();
  }

  Future<void> _pause() async {
    final provider = Provider.of<BookProvider>(context, listen: false);
    await _audioPlayer.pause();
    provider.pause();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BookProvider>(context);
    final book = provider.currentBook ?? (provider.books.isNotEmpty ? provider.books[0] : null);

    if (book == null) return SizedBox(height: widget.detailedScreen ? 90 : 65);

    final theme = Theme.of(context).colorScheme;

    Color mainRed = theme.primary;
    Color accentRed = theme.tertiary;

    final bool isCurrent = (_activeBook?.id ?? book.id) == book.id;
    final bool isPlaying = isCurrent && (
        _state == PlayerState.playing || provider.isPlaying);

    return Material(
      elevation: widget.detailedScreen ? 5 : 7,
      color: Colors.white,
      child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: mainRed.withAlpha((0.32 * 255).toInt()),
            width: 2,
          ),
        ),
      ),
      padding: widget.detailedScreen
          ? const EdgeInsets.symmetric(horizontal: 20, vertical: 16)
          : const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              book.coverUrl,
              width: widget.detailedScreen ? 68 : 44,
              height: widget.detailedScreen ? 68 : 44,
              fit: BoxFit.cover,
              errorBuilder: (ctx, _, __) =>
                  Container(width: widget.detailedScreen ? 68 : 44, height: widget.detailedScreen ? 68 : 44, color: Colors.grey[300]),
            ),
          ),
          const SizedBox(width: 16),
          if (widget.detailedScreen)
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: mainRed,
                          fontSize: 19)),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: theme.secondary,
                        fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.timer, size: 16, color: accentRed),
                      const SizedBox(width: 2),
                      Text(_formatDuration(book.durationSeconds), style: const TextStyle(fontSize: 13))
                    ],
                  ),
                ],
              ),
            )
          else
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: mainRed,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  Text(
                    book.author,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: theme.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          const SizedBox(width: 8),
          // Seek bar (if the detailed view)
          if (widget.detailedScreen)
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Slider(
                    thumbColor: accentRed,
                    activeColor: accentRed,
                    inactiveColor: accentRed.withAlpha((0.18 * 255).toInt()),
                    min: 0,
                    max: (_duration.inSeconds).toDouble(),
                    value: _pos.inSeconds <= _duration.inSeconds
                        ? _pos.inSeconds.toDouble()
                        : 0,
                    onChanged: (value) async {
                      Duration seekTo = Duration(seconds: value.toInt());
                      await _audioPlayer.seek(seekTo);
                      setState(() {
                        _pos = seekTo;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_pos.inSeconds), style: const TextStyle(fontSize: 13)),
                      Text(_formatDuration(_duration.inSeconds), style: const TextStyle(fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
          IconButton(
            icon: isPlaying
                ? Icon(Icons.pause_circle_filled,
                        color: mainRed, size: widget.detailedScreen ? 52 : 36)
                : Icon(Icons.play_circle_fill,
                        color: mainRed, size: widget.detailedScreen ? 52 : 36),
            onPressed: () {
              if (isPlaying) {
                _pause();
              } else {
                _play(book);
              }
            },
          ),
        ],
      ),
    ));
  }
}

//#endregion

//#region --- Utility ---
String _formatDuration(int seconds) {
  final duration = Duration(seconds: seconds);

  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final hours = duration.inHours;
  final minutes = duration.inMinutes % 60;
  final secs = duration.inSeconds % 60;
  if (hours > 0) {
    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(secs)}';
  } else {
    return '${twoDigits(minutes)}:${twoDigits(secs)}';
  }
}
//#endregion
