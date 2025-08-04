1. Tabela Cliente
CREATE TABLE Cliente (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(20),
    endereco VARCHAR(150)
);

2. Tabela Veículo
CREATE TABLE Veiculo (
    id_veiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10) UNIQUE NOT NULL,
    modelo VARCHAR(50),
    marca VARCHAR(50),
    ano INT,
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
);

3. Tabela Equipe
CREATE TABLE Equipe (
    id_equipe INT AUTO_INCREMENT PRIMARY KEY,
    nome_equipe VARCHAR(50)
);

4. Tabela Mecânico
CREATE TABLE Mecanico (
    id_mecanico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    endereco VARCHAR(150),
    especialidade VARCHAR(50),
    id_equipe INT,
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

5. Tabela Ordem de Serviço
CREATE TABLE OrdemServico (
    id_os INT AUTO_INCREMENT PRIMARY KEY,
    numero_os VARCHAR(20) UNIQUE NOT NULL,
    data_emissao DATE NOT NULL,
    data_conclusao DATE,
    valor_total DECIMAL(10,2),
    status ENUM('Aberta', 'Em execução', 'Concluída', 'Cancelada') DEFAULT 'Aberta',
    id_veiculo INT,
    id_equipe INT,
    FOREIGN KEY (id_veiculo) REFERENCES Veiculo(id_veiculo),
    FOREIGN KEY (id_equipe) REFERENCES Equipe(id_equipe)
);

6. Tabela Serviço
CREATE TABLE Servico (
    id_servico INT AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(100) NOT NULL,
    valor_mao_obra DECIMAL(10,2) NOT NULL
);

7. Associação OS-Serviço (N:M)
CREATE TABLE OS_Servico (
    id_os INT,
    id_servico INT,
    autorizado ENUM('S', 'N') DEFAULT 'S',
    PRIMARY KEY (id_os, id_servico),
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os),
    FOREIGN KEY (id_servico) REFERENCES Servico(id_servico)
);

8. Tabela Peça
CREATE TABLE Peca (
    id_peca INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    valor_unitario DECIMAL(10,2) NOT NULL
);

9. Associação OS-Peça (N:M)
CREATE TABLE OS_Peca (
    id_os INT,
    id_peca INT,
    quantidade INT NOT NULL DEFAULT 1,
    PRIMARY KEY (id_os, id_peca),
    FOREIGN KEY (id_os) REFERENCES OrdemServico(id_os),
    FOREIGN KEY (id_peca) REFERENCES Peca(id_peca)
);


Instãncias:

1. Cliente
INSERT INTO Cliente (nome, telefone, endereco) VALUES
('João Silva', '11999999999', 'Rua das Flores, 123'),
('Maria Oliveira', '21988888888', 'Av. Brasil, 456'),
('Carlos Souza', '31977777777', 'Rua Minas, 789');

2. Veículo
INSERT INTO Veiculo (placa, modelo, marca, ano, id_cliente) VALUES
('ABC1234', 'Civic', 'Honda', 2015, 1),
('XYZ5678', 'Corolla', 'Toyota', 2018, 2),
('JKL9012', 'Uno', 'Fiat', 2012, 3);

3. Equipe
INSERT INTO Equipe (nome_equipe) VALUES
('Equipe Alfa'),
('Equipe Beta');

 4. Mecânico
INSERT INTO Mecanico (nome, endereco, especialidade, id_equipe) VALUES
('Pedro Lima', 'Rua A, 100', 'Motor', 1),
('Ana Costa', 'Rua B, 200', 'Freios', 1),
('José Mendes', 'Rua C, 300', 'Suspensão', 2);

5. Ordem de Serviço
INSERT INTO OrdemServico (numero_os, data_emissao, data_conclusao, valor_total, status, id_veiculo, id_equipe) VALUES
('OS1001', '2025-08-01', '2025-08-03', 750.00, 'Concluída', 1, 1),
('OS1002', '2025-08-02', NULL, 0.00, 'Aberta', 2, 2);

 6. Serviço
INSERT INTO Servico (descricao, valor_mao_obra) VALUES
('Troca de óleo', 120.00),
('Alinhamento', 80.00),
('Revisão geral', 300.00);

7. OS_Servico
INSERT INTO OS_Servico (id_os, id_servico, autorizado) VALUES
(1, 1, 'S'),
(1, 3, 'S'),
(2, 2, 'N');

 8. Peça
INSERT INTO Peca (nome, valor_unitario) VALUES
('Filtro de óleo', 40.00),
('Pastilha de freio', 120.00),
('Amortecedor', 250.00);

 9. OS_Peca
INSERT INTO OS_Peca (id_os, id_peca, quantidade) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 2);
