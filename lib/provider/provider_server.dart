import 'package:flutter/material.dart';
import '../database/sqlflite_server.dart';

class ProviderServer extends ChangeNotifier {
  int? _id;
  String? _title;
  bool _isLoading = false;
  String? _des;
  String? _image;
  bool _isgridorlist = true;
  String? _date;
  String _currentSort = "newest";
  bool _isSearching = false;
  double _thefontsizetitle = 20;
  double _thefontsizedesc = 18;
  bool _isdarktheme = true;

  bool get isLoading => _isLoading;
  int? get id => _id;
  String? get title => _title;
  bool get isgridorlist => _isgridorlist;
  String? get des => _des;
  String? get image => _image;
  String? get date => _date;
  String get currentSort => _currentSort;
  bool get isSearching => _isSearching;
  double get thefontsizetitle => _thefontsizetitle;
  double get thefontsizedesc => _thefontsizedesc;
  List<Map<String, dynamic>> notes = [];
  List<Map<String, dynamic>> trashNotes = [];

  SqlfliteServer sqlfliteServer = SqlfliteServer();
  bool get isdarktheme => _isdarktheme;

  void _setLoading(bool val) {
    if (_isLoading != val) {
      _isLoading = val;
      notifyListeners();
    }
  }

  void updatethefontsizetitle(double thesize) {
    _thefontsizetitle = thesize;
    notifyListeners();
  }
  
  void updatisgridorlist() {
    _isgridorlist = !_isgridorlist;
    notifyListeners();
  }

  void updatethefontsizedesc(double thesize) {
    _thefontsizedesc = thesize;
    notifyListeners();
  }

  void updateId(int id) {
    _id = id;
    notifyListeners();
  }

  void updateisDarkTheme(bool inst) {
    _isdarktheme = inst;
    notifyListeners();
  }

  void updateTitle(String? value) {
    _title = value ?? '';
    notifyListeners();
  }

  void updateSort(String value) {
    _currentSort = value;
    notifyListeners();
  }

  void updateDes(String? value) {
    _des = value ?? '';
    notifyListeners();
  }

  void updateImage(String? value) {
    _image = value ?? '';
    notifyListeners();
  }

  void updateDate(String? value) {
    _date = value ?? '';
    notifyListeners();
  }

  Future<void> loadhomepage({bool? newest}) async {
    if (_isSearching) return;
    _setLoading(true);
    try {
      notes = await sqlfliteServer.getActiveNotes(newest: newest ?? true);
    } catch (e) {
      print('Error loading homepage notes: $e');
    }
    _setLoading(false);
  }

  Future<void> loadNote({bool? newest}) async {
    if (_isSearching) return;
    _setLoading(true);
    try {
      notes = await sqlfliteServer.getActiveNotes(newest: newest ?? true);
    } catch (e) {
      print('Error loading notes: $e');
    }
    _setLoading(false);
  }

  Future<void> loadTrash() async {
    try {
      trashNotes = await sqlfliteServer.getTrashNotes();
      notifyListeners();
    } catch (e) {
      print('Error loading trash notes: $e');
    }
  }

  Future<void> addNote() async {
    if (des == null || des!.isEmpty) return;
    try {
      await sqlfliteServer.insertdata(
        title ?? '',
        des ?? '',
        image ?? '',
        date ?? '',
      );
      await loadNote(newest: _currentSort == "newest");
    } catch (e) {
      print('Error adding note: $e');
    }
  }

  Future<void> deleteItem(int id) async {
    try {
      await sqlfliteServer.moveToTrash(id);
      await loadNote(newest: _currentSort == "newest");
    } catch (e) {
      print('Error deleting note: $e');
    }
  }

  Future<void> restoreItem(int id) async {
    try {
      await sqlfliteServer.restoreFromTrash(id);
      _isSearching = false;
      await loadNote(newest: _currentSort == "newest");
      await loadTrash();
    } catch (e) {
      print('Error restoring note: $e');
    }
  }

  Future<void> deleteForever(int id) async {
    try {
      await sqlfliteServer.deleteForever(id);
      await loadTrash();
    } catch (e) {
      print('Error deleting note forever: $e');
    }
  }

  Future<void> updateData() async {
    if (id == null) return;
    try {
      await sqlfliteServer.updateData(id!, title!, des!, image!, date!);
      await loadNote(newest: _currentSort == "newest");
    } catch (e) {
      print('Error updating note: $e');
    }
  }

  Future<void> orderData(bool inst) async {
    await loadNote(newest: inst);
  }

  Future<void> searchItem(String title) async {
    _isSearching = true;
    try {
      notes = await sqlfliteServer.searchByTitle(title);
      notifyListeners();
    } catch (e) {
      print('Error searching notes: $e');
    }
  }

  Future<void> stopSearching() async {
    _isSearching = false;
    await loadNote(newest: _currentSort == "newest");
  }

  void clear() {
    _title = '';
    _des = '';
    _image = '';
    notifyListeners();
  }
}
