DROP DATABASE IF EXISTS bd_oficina_mecanica;
CREATE DATABASE bd_oficina_mecanica;
USE bd_oficina_mecanica;

DROP TABLE IF EXISTS OrdemDeServico;
DROP TABLE IF EXISTS PedidoGerado;
DROP TABLE IF EXISTS Responsavel;
DROP TABLE IF EXISTS Pedido;
DROP TABLE IF EXISTS Cliente;

CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY,
    NomeCompleto VARCHAR(45),
    Contato VARCHAR(15),
    Perfil VARCHAR(45)
);

CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY,
    Cliente_idCliente INT,
    TituloPedido VARCHAR(45),
    Descricao VARCHAR(255),
    TipoProblema ENUM('Mecanico', 'Eletrico', 'Pintura', 'Revisao'),
    Prioridade ENUM('Alta', 'Media', 'Baixa'),
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

CREATE TABLE Responsavel (
    idResponsavel INT PRIMARY KEY,
    Setor VARCHAR(45),
    Matricula VARCHAR(45),
    Cargo VARCHAR(45)
);

CREATE TABLE PedidoGerado (
    Pedido_idPedido INT,
    Responsavel_idResponsavel INT,
    SetorResponsavel VARCHAR(45),
    Comentarios VARCHAR(45),
    SetorEncaminhado VARCHAR(45),
    PRIMARY KEY (Pedido_idPedido, Responsavel_idResponsavel),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Responsavel_idResponsavel) REFERENCES Responsavel(idResponsavel)
);

CREATE TABLE OrdemDeServico (
    idOrdemDeServico INT PRIMARY KEY,
    Descricao VARCHAR(45),
    Prioridade ENUM('Alta', 'Media', 'Baixa'),
    Pedido_has_Responsavel_Pedido_idPedido INT,
    Pedido_has_Responsavel_Pedido_Cliente_idCliente INT,
    Pedido_has_Responsavel_Responsavel_idResponsavel INT,
    FOREIGN KEY (Pedido_has_Responsavel_Pedido_idPedido) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Pedido_has_Responsavel_Pedido_Cliente_idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Pedido_has_Responsavel_Responsavel_idResponsavel) REFERENCES Responsavel(idResponsavel)
);

INSERT INTO Cliente (idCliente, NomeCompleto, Contato, Perfil) VALUES
(1, 'João Silva', '11987654321', 'Regular'),
(2, 'Maria Oliveira', '11987654322', 'VIP'),
(3, 'Carlos Pereira', '11987654323', 'Regular'),
(4, 'Ana Souza', '11987654324', 'VIP'),
(5, 'Pedro Lima', '11987654325', 'Regular'),
(6, 'Fernanda Costa', '11987654326', 'VIP'),
(7, 'Ricardo Santos', '11987654327', 'Regular'),
(8, 'Juliana Almeida', '11987654328', 'VIP'),
(9, 'Roberto Nunes', '11987654329', 'Regular'),
(10, 'Patricia Mendes', '11987654330', 'VIP');

INSERT INTO Pedido (idPedido, Cliente_idCliente, TituloPedido, Descricao, TipoProblema, Prioridade) VALUES
(1, 1, 'Troca de Óleo', 'Substituição do óleo do motor', 'Mecanico', 'Media'),
(2, 2, 'Revisão Elétrica', 'Verificação do sistema elétrico', 'Eletrico', 'Alta'),
(3, 3, 'Pintura Completa', 'Pintura de todo o veículo', 'Pintura', 'Baixa'),
(4, 4, 'Revisão Geral', 'Manutenção completa do carro', 'Revisao', 'Alta'),
(5, 5, 'Troca de Pneus', 'Substituição dos pneus desgastados', 'Mecanico', 'Media'),
(6, 6, 'Revisão de Freios', 'Verificação e troca de pastilhas de freio', 'Mecanico', 'Alta'),
(7, 7, 'Troca da Bateria', 'Substituição de bateria antiga', 'Eletrico', 'Media'),
(8, 8, 'Alinhamento', 'Correção do alinhamento das rodas', 'Mecanico', 'Baixa'),
(9, 9, 'Balanceamento', 'Balanceamento das rodas', 'Mecanico', 'Media'),
(10, 10, 'Ajuste de Suspensão', 'Revisão e ajustes na suspensão', 'Revisao', 'Alta');

INSERT INTO Responsavel (idResponsavel, Setor, Matricula, Cargo) VALUES
(1, 'Mecânica', 'ME1001', 'Mecânico'),
(2, 'Elétrica', 'EL2001', 'Eletricista'),
(3, 'Pintura', 'PI3001', 'Pintor'),
(4, 'Revisão', 'RV4001', 'Técnico de Revisão'),
(5, 'Mecânica', 'ME1002', 'Mecânico'),
(6, 'Elétrica', 'EL2002', 'Eletricista'),
(7, 'Pintura', 'PI3002', 'Pintor'),
(8, 'Revisão', 'RV4002', 'Técnico de Revisão'),
(9, 'Mecânica', 'ME1003', 'Mecânico'),
(10, 'Elétrica', 'EL2003', 'Eletricista');

INSERT INTO PedidoGerado (Pedido_idPedido, Responsavel_idResponsavel, SetorResponsavel, Comentarios, SetorEncaminhado) VALUES
(1, 1, 'Mecânica', 'Agendar troca de óleo', 'Mecânica'),
(2, 2, 'Elétrica', 'Verificar fusíveis', 'Elétrica'),
(3, 3, 'Pintura', 'Preparar ambiente para pintura', 'Pintura'),
(4, 4, 'Revisão', 'Agendar revisão completa', 'Revisão'),
(5, 5, 'Mecânica', 'Checar pneus e suspensão', 'Mecânica'),
(6, 2, 'Elétrica', 'Inspecionar sistema elétrico', 'Elétrica'),
(7, 6, 'Elétrica', 'Recomendar troca de bateria', 'Elétrica'),
(8, 1, 'Mecânica', 'Ajuste de alinhamento necessário', 'Mecânica'),
(9, 9, 'Mecânica', 'Realizar balanceamento', 'Mecânica'),
(10, 4, 'Revisão', 'Verificar ajustes na suspensão', 'Revisão');

INSERT INTO OrdemDeServico (idOrdemDeServico, Descricao, Prioridade, Pedido_has_Responsavel_Pedido_idPedido, Pedido_has_Responsavel_Pedido_Cliente_idCliente, Pedido_has_Responsavel_Responsavel_idResponsavel) VALUES
(1, 'Ordem para troca de óleo', 'Media', 1, 1, 1),
(2, 'Ordem para revisão elétrica', 'Alta', 2, 2, 2),
(3, 'Ordem para pintura do carro', 'Baixa', 3, 3, 3),
(4, 'Ordem para revisão geral', 'Alta', 4, 4, 4),
(5, 'Ordem para troca de pneus', 'Media', 5, 5, 5),
(6, 'Ordem para revisão de freios', 'Alta', 6, 6, 2),
(7, 'Ordem para troca de bateria', 'Media', 7, 7, 6),
(8, 'Ordem para alinhamento', 'Baixa', 8, 8, 1),
(9, 'Ordem para balanceamento', 'Media', 9, 9, 9),
(10, 'Ordem para ajuste de suspensão', 'Alta', 10, 10, 4);

-- Liste todos os clientes cadastrados.
SELECT idCliente, NomeCompleto, Contato, Perfil
FROM Cliente;

-- Quais pedidos têm prioridade "Alta"?
SELECT idPedido, TituloPedido, Descricao, TipoProblema, Prioridade
FROM Pedido
WHERE Prioridade = 'Alta';

-- Mostre os pedidos com a contagem de palavras no campo Descricao (exemplo de atributo derivado).
SELECT idPedido, TituloPedido, Descricao, 
       LENGTH(Descricao) - LENGTH(REPLACE(Descricao, ' ', '')) + 1 AS QtdePalavras
FROM Pedido;

-- Quais são os pedidos organizados por título (ordem alfabética) e por prioridade (alta para baixa)?
SELECT idPedido, TituloPedido, TipoProblema, Prioridade
FROM Pedido
ORDER BY FIELD(Prioridade, 'Alta', 'Media', 'Baixa') ASC, TituloPedido ASC;

-- Liste os setores e quantos pedidos estão associados a cada setor, mas somente setores com mais de 2 pedidos.
SELECT SetorResponsavel, COUNT(*) AS TotalPedidos
FROM PedidoGerado
GROUP BY SetorResponsavel
HAVING COUNT(*) > 2;

-- Quais são os pedidos de clientes VIP e seus respectivos responsáveis?
SELECT c.NomeCompleto AS Cliente, c.Perfil, p.TituloPedido, r.Matricula AS Responsavel, r.Cargo
FROM Pedido p
JOIN Cliente c ON p.Cliente_idCliente = c.idCliente
JOIN PedidoGerado pg ON p.idPedido = pg.Pedido_idPedido
JOIN Responsavel r ON pg.Responsavel_idResponsavel = r.idResponsavel
WHERE c.Perfil = 'VIP';
