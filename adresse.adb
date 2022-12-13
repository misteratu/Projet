package body adresse is

    procedure Construire_exemple_adresse (IP1 : out T_Adresse_IP) is 
    begin
        IP1 := 147;
        IP1 := IP1 * UN_OCTET + 128;
        IP1 := IP1 * UN_OCTET + 18;
        IP1 := IP1 * UN_OCTET + 15;
        Put(IP1);
    end Construire_exemple_adresse;

    function Bit_poid_fort_1 (IP1 : in T_Adresse_IP) is
    begin
        return (IP1 and POIDS_FORT) /= 0;
    end Bit_poid_fort_1;

    procedure Construire_exemple_masque (M1 : out T_Adresse_IP) is
    begin   
        
        M1 := 255;
        M1 := M1 * UN_OCTET + 255;
        M1 := M1 * UN_OCTET + 255;
        M1 := M1 * UN_OCTET + 0;
        Put(M1);

    end Construire_exemple_masque;

    procedure Construire_exemple_destination (M1 : out T_Adresse_IP) is
    begin   
        D1 := 147;
        D1 := D1 * UN_OCTET + 128;
        D1 := D1 * UN_OCTET + 18;
        D1 := D1 * UN_OCTET + 0;
        Put(D1);
	end Construire_exemple_destination;

    function Adresse_correspondante (IP1 : in T_Adresse_IP; M1 : in T_Adresse_IP; D1 : in T_Adresse_IP) is
    begin
        return (IP1 and M1) = D1;
    end Adresse_correspondante;
		  


end adresse;