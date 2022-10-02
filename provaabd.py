from sqlalchemy.orm import declarative_base, relationship, sessionmaker
from sqlalchemy import Column,ForeignKey, Integer, String, create_engine, Table

URL="mysql+mysqlconnector://root:joao123@127.0.0.1:3306/intro_orm"
engine = create_engine(url=URL)
Base = declarative_base()

loja_produto = Table('loja_produto',Base.metadata,
    Column('id_loja',Integer,ForeignKey('loja.id_loja')),
    Column('id_produto',Integer,ForeignKey('produto.id_produto'))
)

endereco_pessoa = Table('endereco_pessoa',Base.metadata,
    Column('id_pessoa',Integer,ForeignKey('pessoa.id_pessoa')),
    Column('id_endereco',Integer,ForeignKey('endereco.id_endereco'))
)

class Comprasprodutos(Base):
    __tablename__ = "comprasprodutos"
    id_compraproduto = Column(Integer, primary_key=True)
    quantidade = Column(Integer, nullable=True)
    id_compra = Column(Integer,ForeignKey('compra.id_compra'))
    id_produto = Column(Integer,ForeignKey('produto.id_produto'))

class Pais(Base):
    __tablename__ = "pais"
    id_pais = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=True)
    estado = relationship("Estado", backref="pais")

class Estado(Base):
    __tablename__ = "estado"
    id_estado = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=True)
    id_pais = Column(Integer, ForeignKey("pais.id_pais"))
    cidade = relationship("Cidade", backref="estado")

class Cidade(Base):
    __tablename__ = "cidade"
    id_cidade = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=True)
    id_estado = Column(Integer, ForeignKey("estado.id_estado"))
    endereco = relationship("Endereco", backref="cidade")

class Endereco(Base):
    __tablename__ = "endereco"
    id_endereco = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=True)
    CEP = Column(String(150), nullable=True)
    numero = Column(Integer, nullable=True)
    id_cidade = Column(Integer, ForeignKey("cidade.id_cidade"))
    loja = relationship("Loja", backref="endereco",uselist=False)

class Loja(Base):
    __tablename__ = "loja"
    id_loja = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=True)
    id_endereco = Column(Integer, ForeignKey("endereco.id_endereco"))
    possui = relationship("Produto", secondary=loja_produto, backref='pertence')
    compra = relationship("Compra", backref="loja",uselist=False)

class Produto(Base):
    __tablename__ = "produto"
    id_produto = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=True)
    preco = Column(Integer, nullable=True)
    quantidade = Column(Integer, nullable=True)
    comprasprodutos = relationship("Comprasprodutos", backref="produto")

class Pessoa(Base):
    __tablename__ = "pessoa"
    id_pessoa = Column(Integer, primary_key=True)
    nome = Column(String(150), nullable=True)
    CPF = Column(Integer, nullable=True)
    cliente = relationship("Cliente", backref="pessoa",uselist=False)
    vendedor = relationship("Vendedor", backref="pessoa",uselist=False)
    possui = relationship("Endereco", secondary=endereco_pessoa, backref='pertence')
    
class Cliente(Base):
    __tablename__ = "cliente"
    id_cliente = Column(Integer, primary_key=True)
    id_pessoa = Column(Integer, ForeignKey("pessoa.id_pessoa"))
    compra = relationship("Compra", backref="cliente",uselist=False)

class Vendedor(Base):
    __tablename__ = "vendedor"
    id_vendedor = Column(Integer, primary_key=True)
    id_pessoa = Column(Integer, ForeignKey("pessoa.id_pessoa"))
    compra = relationship("Compra", backref="vendedor",uselist=False)

class Compra(Base):
    __tablename__ = "compra"
    id_compra = Column(Integer, primary_key=True)
    id_cliente = Column(Integer, ForeignKey("cliente.id_cliente"))
    id_vendedor = Column(Integer, ForeignKey("vendedor.id_vendedor"))
    id_loja = Column(Integer, ForeignKey("loja.id_loja"))
    compra_produto = relationship("Comprasprodutos", backref="compra")

Base.metadata.create_all(engine)
