import 'package:hive/hive.dart';
import 'package:pulsepower_258/logic_prem/get_premium/sdfsdf/sdfsdfs.dart';

class Hdrgsg {
  Future<ADfsdfs?> dfgsg() async {
    final box = await Hive.openBox<ADfsdfs>('dsfdf');
    final result = box.get('dfs');
    return result;
  }

  sdgsdg(ADfsdfs model) async {
    final box = await Hive.openBox<ADfsdfs>('dsfdf');
    box.put('dfs', model);
  }
}
