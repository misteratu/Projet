
-- D�finition de structures de donn�es associatives sous forme d'une liste
-- cha�n�e associative (Cache).
generic	
	type T_Destination is private;
	type T_Masque is private;
	type T_Eth is private;

package Cache is

	type T_Cache is limited private;

	-- Initialiser une Sda.  La Sda est vide.
	procedure Initialiser(Sda: out T_Cache) with
		Post => Est_Vide (Sda);


	-- Est-ce qu'une Sda est vide ?
	function Est_Vide (Sda : T_Cache) return Boolean;


	-- Obtenir le nombre d'�l�ments d'une Sda. 
	function Taille (Sda : in T_Cache) return Integer with
		Post => Taille'Result >= 0
			and (Taille'Result = 0) = Est_Vide (Sda);


	-- Enregistrer une Donn�e associ�e � une Cl� dans une Sda.
	-- Si la cl� est d�j� pr�sente dans la Sda, sa donn�e est chang�e.
	procedure Enregistrer (Sda : in out T_Cache ; Destination : in T_Destination ; Masque : in T_Masque ; Eth : in T_Eth) with
		Post => Destination_Presente (Sda, Destination)  -- donn�e ins�r�e
				and (not (Destination_Presente (Sda, Destination)'Old) or Taille (Sda) = Taille (Sda)'Old)
				and (Destination_Presente (Sda, Destination)'Old or Taille (Sda) = Taille (Sda)'Old + 1);

	-- Supprimer la Donn�e associ�e � une Cl� dans une Sda.
	-- Exception : Cle_Absente_Exception si Cl� n'est pas utilis�e dans la Sda
	procedure Supprimer (Sda : in out T_Cache ; Destination : in T_Destination) with
		Post =>  Taille (Sda) = Taille (Sda)'Old - 1 -- un �l�ment de moins
			and not Destination_Presente (Sda, Destination);         -- la cl� a �t� supprim�e


	-- Savoir si une Cl� est pr�sente dans une Sda.
	function Destination_Presente (Sda : in T_Cache ; Destination : in T_Destination) return Boolean;

	-- Supprimer tous les �l�ments d'une Sda.
	procedure Vider (Sda : in out T_Cache) with
		Post => Est_Vide (Sda);


private
	type T_Cellule;

		type T_Cache is access T_Cellule;

		type T_Cellule is
			record
				Destination : T_Destination;
				Masque : T_Masque;
				Eth : T_Eth;
				Suivant : T_Cache;
			end record;
	-- TODO : � compl�ter

end Cache;
