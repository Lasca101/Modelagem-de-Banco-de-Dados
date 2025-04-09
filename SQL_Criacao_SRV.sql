CREATE SCHEMA MYDB;

SET search_path TO MYDB;

CREATE TABLE VOO (
   IdVoo INT PRIMARY KEY,
   Numero VARCHAR(10) NOT NULL,
   Companhia_Aerea VARCHAR(100) NOT NULL,
   Nome_Aeroporto_Origem VARCHAR(100) NOT NULL,
   Nome_Aeroporto_Destino VARCHAR(100) NOT NULL,
   Data_Hora_Saida TIMESTAMP NOT NULL,
   Data_Hora_Chegada TIMESTAMP NOT NULL
);

CREATE TABLE TRIPULACAO (
   CPF_T CHAR(11) PRIMARY KEY,
   Primeiro_Nome VARCHAR(50) NOT NULL,
   Sobrenome VARCHAR(50) NOT NULL,
   Telefone VARCHAR(15) NOT NULL,
   Cargo VARCHAR(50) NOT NULL
);

CREATE TABLE TRIPULACAO_VOO (
   TV_IdVoo INT,
   TV_CPF_T CHAR(11),
   PRIMARY KEY (TV_IdVoo, TV_CPF_T),
   FOREIGN KEY (TV_IdVoo) REFERENCES VOO(IdVoo),
   FOREIGN KEY (TV_CPF_T) REFERENCES TRIPULACAO(CPF_T)
);

CREATE TABLE PASSAGEIRO (
   CPF_P CHAR(11) PRIMARY KEY,
   Primeiro_Nome VARCHAR(50) NOT NULL,
   Sobrenome VARCHAR(50) NOT NULL,
   Data_Nascimento DATE NOT NULL,
   Telefone VARCHAR(15),
   Email VARCHAR(100)
);

CREATE TABLE ASSENTO (
   IdAssento INT PRIMARY KEY,
   Numero VARCHAR(4) NOT NULL,
   Status BOOLEAN NOT NULL,
   Classe VARCHAR(20) NOT NULL,
   Assento_IdVoo INT NOT NULL,
   FOREIGN KEY (Assento_IdVoo) REFERENCES VOO(IdVoo)
);

CREATE TABLE RESERVA (
   IdReserva INT,
   Reserva_CPF_P CHAR(11),
   Reserva_IdVoo INT NOT NULL,
   Reserva_IdAssento INT NOT NULL,
   Data DATE NOT NULL,
   PRIMARY KEY (IdReserva, Reserva_CPF_P),
   FOREIGN KEY (Reserva_CPF_P) REFERENCES PASSAGEIRO(CPF_P),
   FOREIGN KEY (Reserva_IdVoo) REFERENCES VOO(IdVoo),
   FOREIGN KEY (Reserva_IdAssento) REFERENCES ASSENTO(IdAssento),
   UNIQUE (Reserva_IdVoo, Reserva_IdAssento)
);

CREATE TABLE BAGAGEM (
   IdBagagem INT,
   Bagagem_Reserva_IdReserva INT,
   Bagagem_Reserva_CPF_P CHAR(11),
   Tipo VARCHAR(50) NOT NULL,
   Altura DECIMAL(5, 2) NOT NULL,
   Comprimento DECIMAL(5, 2) NOT NULL,
   Largura DECIMAL(5, 2) NOT NULL,
   Peso DECIMAL(5, 2) NOT NULL,
   PRIMARY KEY (IdBagagem, Bagagem_Reserva_IdReserva, Bagagem_Reserva_CPF_P),
   FOREIGN KEY (Bagagem_Reserva_IdReserva, Bagagem_Reserva_CPF_P) REFERENCES RESERVA(IdReserva, Reserva_CPF_P)
);

CREATE TABLE PAGAMENTO (
   IdPagamento INT,
   Pagamento_Reserva_IdReserva INT,
   Pagamento_Reserva_CPF_P CHAR(11),
   Status VARCHAR(20) NOT NULL,
   Metodo_Pagamento VARCHAR(50) NOT NULL,
   Valor DECIMAL(10, 2) NOT NULL,
   Data_Pagamento DATE,
   PRIMARY KEY (IdPagamento, Pagamento_Reserva_IdReserva, Pagamento_Reserva_CPF_P),
   FOREIGN KEY (Pagamento_Reserva_IdReserva, Pagamento_Reserva_CPF_P) REFERENCES RESERVA(IdReserva, Reserva_CPF_P)
);
