# RBAC exercise

## Scenario One:
- We were asked to deploy a mysql instance that uses a secret named "database-access" to set credentials.
- User Dave (context=dave), as developer must be able only to manage deployments and pods in namespace "staging". To make him able to troubleshoot issues allow him also the capability to watch console output.
- User Bob (context=bob), as DBA must be the unique user who can view/manage secrent named "database-access" in namespaces "staging" and "production"
- A serviceaccount named "spinnaker" must be able to deploy the resources created by Dave and Bob in "production" namespace.

Questions:
1. Can we grant Dave permission to create secrets without expossing the dabase credentials?
2. Is database secret really secured in this scene?, what do we have to change to make it really secure?

<details close>
<summary> Solution</summary>
<br>
### Solution
    
EnCt2ddb22ccdf22d68c21fa0c5d299ba10ffae6c29dbddb22ccdf22d68c21fa0c5d2o3bSnNe70AJ
KPpMrEmLpVd486NaXbKXg8SfOUI+BM8skAWZZWN+I8k0DSLLt0SjhC7/mzSlyze6AfKlr6FwUizuNRuK
DzE1UaMLvZpv/AtJhVErX4LZhH2XxRrc0XwnEnIlfDNdWhfcgF+KW+HTkU3mMZtN7GSLNI2ebFf1CeBU
ry7T5QUq6KqvTKKHBzM1DFz4QzEJChAH5Xn8Z9XZvJtP9Bc7ejwPXY58T9b6DMRgumhkYoI7GFuOVD22
Ie7LSE0HpIsGJQDgP4uabpsZs5NKvhX6V4PXoxfF1u8YMqNEAXEacRpemLkBv+joYeL3/pqKIMQo6HDl
mce1W4PXbecDrKFuSlV8I+NYvwHzmEKUMLm1HY8RXBk5R1iA/gUCuc2hb1Ncc+ALHRaGbiH1WYlx6cIJ
caL4HmkPKVeqd8l5q6veuGxYI4HjSjaqNG4sqj9cXSlB4zWJWHGVJkBmkGVKmgk/vAKntUdLGnb4W7LR
RF79co4uYLioH56EEH4PnB6yiIo+PyXmWcDOVzvk/groNFiFbSndw+3fDUBR3dtQZLc7L9rpJGUCEhQ5
yjU0O4sbWjo5EykuSSiwL7p+IfdzhFBEUOUYY05H26R3hmXHSNXIABfJW2T7a18GMTocwSh9GkUfpPZB
VwxksOpTG1AUyesncikt5fMq124qfs7DqA9+i8KRYVB96hbVOsE5TePeX6BI8t/LPlqbFkBdx+OCMcML
ZXqBpBQrAv+BQoeus67a+EFt3QSwFVYceS/KFdiC5vz+o/OTZ2KSW/TB1D2SgTiaA6p9BPWqWN5Cmvb1
IlSN7et5s7r3yPEu/gWIq8+OY/jhUp8u6i8mH11GPqnRcIHhrFv+7c/oOCdmHx4K6BL5Ludv70Nj27S+
xKYRrU+/jWtQuCRnPy1AmCdC6h3BaputgsNxVMqmDkmTUe6AEVVHIo6KyzNGTcnpXl71imOL/W5LZjeM
rv4PPNtgvjWQ4YBjZ9m/m4LYIwZPYuLUf2Fow97Myhpg/lfNWKFHyA2VJ33qjgp7zKsFimrLo7uwpQOO
0Uf1wYkPzMHchO7Qz19JWj79nlD8P06z4N+n+75SWDjtGLhI7nIsxSyIBjR66IOebknWA9FstCqFZpF0
Mv3Euw7/8zQ8LOGr64MviNKojIs6SospUR0AJvqGvyNhMkd5pjtWZCMv9Qc3Kio+/cdLImRQSeer2HgU
CIyx2dcsCJZRCtZA65CXbzuTWGFUlTL1GIMYBmqNAKbrWhvoSnv6tGg9Ck2XMzsRjolCrmNyhKQgASC8
1rqKe1QfChAdoFGwsqf6RinFfOhNcQMnN4K23sE9ojPEx7gNSRuUdQTxU/WXESE3XLXJK61kgqaS4JLn
iCteFtmA2sQJ1uMD1QXZ5zz8AERjRWXnE8Qqwden/md37BVPOKbL3R5Q6vxgXLUS51UVuwt2eCSF8jMJ
Se4R5r+Dx4ZrGbzAKNUUjez6E8vrvjeHUyMqZyw/CqSAdzGmOoeByhDEF1mKPtW+FFRgZ0VrXpuu0UDK
eJ3Nv93/f21JIrkhAqo/wX1iM+sUntx6LvxXSGSHoPj0JIwEmS

Decrypt it at https://encipher.it
