/// Argon2 算法参数配置
///
/// 与后端 Python Core.py 中的参数保持一致
class Argon2Params {
  Argon2Params._();

  /// 内存成本（KB）- 128 MB
  static const int memoryCost = 131072;

  /// 时间成本（迭代次数）
  static const int timeCost = 6;

  /// 并行度
  static const int parallelism = 6;

  /// 哈希输出长度
  static const int hashLength = 64;

  /// 类型：Argon2id
  static const String type = 'argon2id';

  /// 版本
  static const int version = 19;
}
