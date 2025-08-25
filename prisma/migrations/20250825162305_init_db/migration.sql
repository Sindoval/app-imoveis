-- CreateTable
CREATE TABLE "public"."Usuario" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "senhaHash" TEXT NOT NULL,
    "ativo" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "Usuario_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Role" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,

    CONSTRAINT "Role_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."UsuarioRole" (
    "id" SERIAL NOT NULL,
    "usuarioId" INTEGER NOT NULL,
    "roleId" INTEGER NOT NULL,

    CONSTRAINT "UsuarioRole_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Imovel" (
    "id" SERIAL NOT NULL,
    "endereco" TEXT NOT NULL,
    "cep" TEXT NOT NULL,
    "status" TEXT NOT NULL,
    "valorCompra" DOUBLE PRECISION NOT NULL,
    "valorVenda" DOUBLE PRECISION,

    CONSTRAINT "Imovel_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Investimento" (
    "id" SERIAL NOT NULL,
    "usuarioId" INTEGER NOT NULL,
    "imovelId" INTEGER NOT NULL,
    "valor" DOUBLE PRECISION NOT NULL,
    "data" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Investimento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Produto" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "unidade" TEXT NOT NULL,

    CONSTRAINT "Produto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Estoque" (
    "id" SERIAL NOT NULL,
    "produtoId" INTEGER NOT NULL,
    "quantidade" INTEGER NOT NULL,

    CONSTRAINT "Estoque_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Fornecedor" (
    "id" SERIAL NOT NULL,
    "nome" TEXT NOT NULL,
    "cnpj" TEXT NOT NULL,
    "contato" TEXT NOT NULL,

    CONSTRAINT "Fornecedor_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."FornecedorProduto" (
    "id" SERIAL NOT NULL,
    "fornecedorId" INTEGER NOT NULL,
    "produtoId" INTEGER NOT NULL,
    "preco" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "FornecedorProduto_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Pedido" (
    "id" SERIAL NOT NULL,
    "imovelId" INTEGER NOT NULL,
    "criadoPorId" INTEGER NOT NULL,
    "aprovadoPorId" INTEGER,
    "status" TEXT NOT NULL,

    CONSTRAINT "Pedido_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."PedidoItem" (
    "id" SERIAL NOT NULL,
    "pedidoId" INTEGER NOT NULL,
    "produtoId" INTEGER NOT NULL,
    "quantidade" INTEGER NOT NULL,

    CONSTRAINT "PedidoItem_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."Orcamento" (
    "id" SERIAL NOT NULL,
    "pedidoId" INTEGER NOT NULL,
    "fornecedorId" INTEGER NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "Orcamento_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."OrcamentoItem" (
    "id" SERIAL NOT NULL,
    "orcamentoId" INTEGER NOT NULL,
    "pedidoItemId" INTEGER NOT NULL,
    "precoUnitario" DOUBLE PRECISION NOT NULL,
    "quantidade" INTEGER NOT NULL,
    "subtotal" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "OrcamentoItem_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Usuario_email_key" ON "public"."Usuario"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Estoque_produtoId_key" ON "public"."Estoque"("produtoId");

-- AddForeignKey
ALTER TABLE "public"."UsuarioRole" ADD CONSTRAINT "UsuarioRole_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "public"."Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."UsuarioRole" ADD CONSTRAINT "UsuarioRole_roleId_fkey" FOREIGN KEY ("roleId") REFERENCES "public"."Role"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Investimento" ADD CONSTRAINT "Investimento_usuarioId_fkey" FOREIGN KEY ("usuarioId") REFERENCES "public"."Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Investimento" ADD CONSTRAINT "Investimento_imovelId_fkey" FOREIGN KEY ("imovelId") REFERENCES "public"."Imovel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Estoque" ADD CONSTRAINT "Estoque_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "public"."Produto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."FornecedorProduto" ADD CONSTRAINT "FornecedorProduto_fornecedorId_fkey" FOREIGN KEY ("fornecedorId") REFERENCES "public"."Fornecedor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."FornecedorProduto" ADD CONSTRAINT "FornecedorProduto_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "public"."Produto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Pedido" ADD CONSTRAINT "Pedido_imovelId_fkey" FOREIGN KEY ("imovelId") REFERENCES "public"."Imovel"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Pedido" ADD CONSTRAINT "Pedido_criadoPorId_fkey" FOREIGN KEY ("criadoPorId") REFERENCES "public"."Usuario"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Pedido" ADD CONSTRAINT "Pedido_aprovadoPorId_fkey" FOREIGN KEY ("aprovadoPorId") REFERENCES "public"."Usuario"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PedidoItem" ADD CONSTRAINT "PedidoItem_pedidoId_fkey" FOREIGN KEY ("pedidoId") REFERENCES "public"."Pedido"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."PedidoItem" ADD CONSTRAINT "PedidoItem_produtoId_fkey" FOREIGN KEY ("produtoId") REFERENCES "public"."Produto"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Orcamento" ADD CONSTRAINT "Orcamento_pedidoId_fkey" FOREIGN KEY ("pedidoId") REFERENCES "public"."Pedido"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."Orcamento" ADD CONSTRAINT "Orcamento_fornecedorId_fkey" FOREIGN KEY ("fornecedorId") REFERENCES "public"."Fornecedor"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrcamentoItem" ADD CONSTRAINT "OrcamentoItem_orcamentoId_fkey" FOREIGN KEY ("orcamentoId") REFERENCES "public"."Orcamento"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."OrcamentoItem" ADD CONSTRAINT "OrcamentoItem_pedidoItemId_fkey" FOREIGN KEY ("pedidoItemId") REFERENCES "public"."PedidoItem"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
