public protocol SecretsProvider {
  var marvelPublicKey: String { get }
  var marvelPrivateKey: String { get }
}
