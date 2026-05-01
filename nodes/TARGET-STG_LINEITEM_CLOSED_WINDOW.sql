@id("11111111-1111-4111-8111-111111111101")
@nodeType("a1b2c3d4-e5f6-7890-abcd-ef1234567890")
@materializationType("table")
@insertStrategy("MERGE")
SELECT
  l.L_ORDERKEY AS L_ORDERKEY @isBusinessKey @notNull,
  l.L_LINENUMBER AS L_LINENUMBER @isBusinessKey @notNull,
  l.L_QUANTITY AS L_QUANTITY @isChangeTracking,
  l.L_EXTENDEDPRICE AS L_EXTENDEDPRICE @isChangeTracking,
  l.L_DISCOUNT AS L_DISCOUNT @isChangeTracking,
  l.L_TAX AS L_TAX @isChangeTracking,
  l.L_RETURNFLAG AS L_RETURNFLAG @isChangeTracking,
  l.L_LINESTATUS AS L_LINESTATUS @isChangeTracking,
  l.L_SHIPDATE AS L_SHIPDATE @isChangeTracking,
  l.L_RECEIPTDATE AS L_RECEIPTDATE @isChangeTracking,
  o.O_ORDERDATE AS O_ORDERDATE @isChangeTracking,
  o.O_CUSTKEY AS O_CUSTKEY @isChangeTracking
FROM {{ ref('SRC', 'LINEITEM') }} l
INNER JOIN {{ ref('SRC', 'ORDERS') }} o
  ON l.L_ORDERKEY = o.O_ORDERKEY
WHERE
  l.L_SHIPDATE <= DATEADD(day, -90, TO_DATE('1998-12-01'));
