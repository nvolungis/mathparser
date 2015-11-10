module Tree where 

type Tree = SumNode Operator Tree Tree
          | ProdNode Operator Tree Tree
          | NumNode Float



