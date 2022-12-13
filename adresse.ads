with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;    use Ada.Integer_Text_IO;

package adresse is

	type T_Adresse_IP is mod 2 ** 32;

	UN_OCTET: constant T_Adresse_IP := 2 ** 8;       -- 256
	POIDS_FORT : constant T_Adresse_IP  := 2 ** 31;	 -- 10000000.00000000.00000000.00000000

	IP1 : T_Adresse_IP;
	IP2 : T_Adresse_IP;
	M1 : T_Adresse_IP;
	D1 : T_Adresse_IP;

	Bit_A_1 : Boolean;

	-- Construire 147.127.18.0 (en appliquant le schéma de Horner)
    procedure Construire_exemple_adresse (IP1 : out T_Adresse_IP);
        
	-- Est-ce que le bit de poids fort (1ier bit) est à 1 ?
    function Bit_poid_fort_1 (IP1 : in T_Adresse_IP) return Boolean; 

	-- Construire un masque 255.255.255
    procedure Construire_exemple_masque (M1 : out T_Adresse_IP);

    procedure Construire_exemple_destination (M1 : out T_Adresse_IP);
	
	-- Est-ce qu'une adresse IP1 correspond à la route (D1, M1)
    function Adresse_correspondante (IP1 : in T_Adresse_IP; M1 : in T_Adresse_IP; D1 : in T_Adresse_IP) return Boolean;

end adresse;
