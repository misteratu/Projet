with Ada.Text_IO;            use Ada.Text_IO;
with Ada.Integer_Text_IO;       use Ada.Integer_Text_IO;
with SDA_Exceptions;         use SDA_Exceptions;
with Ada.Unchecked_Deallocation; 

package body Cache is

	procedure Free is
		new Ada.Unchecked_Deallocation (Object => T_Cellule, Name => T_Cache);

-- Initialiser crée une liste chainée qui est null

	procedure Initialiser(Sda: out T_Cache) is
	begin
		Sda := null;	-- TODO : � changer
	end Initialiser;

-- Est_vide permet de verifier si la liste est vide ou non 

	function Est_Vide (Sda : T_Cache) return Boolean is
	begin
		return Sda = null;	-- TODO : � changer
	end Est_Vide;

-- Taille détermine la taille de la liste
-- On parcours la liste en incrémentant jusqu'au moment ou l'on rencontre null

	function Taille (Sda : in T_Cache) return Integer is

	begin
		if Est_Vide(Sda) then
            return 0;
        else
            return 1 + Taille(Sda.all.Suivant);
        end if;
	end Taille;

-- Enregistrer permet d'enregistrer une clé et une donnée dans une liste chainée
-- Sinon on parcours la liste juqu'à trouver notre clé et si la clé est presente alors on affecte la donnée souhaitée à la clé correspondant à la donnée 
-- Si la liste est vide ou que la liste ne contien pas la clé alors on ajoute une cellule dans la liste pour enregistrer Cle et donnee

	procedure Enregistrer (Sda : in out T_Cache ; Destination : in T_Destination ; Masque : in T_Masque ; Eth : in T_Eth) is
	begin
		if Est_Vide(Sda) then	
			Sda := new T_Cellule'(Destination, Masque, Eth, null);
		else
			if Sda.all.Destination = Destination then
				Sda.all.Masque := Masque;
				Sda.all.Eth := Eth;
			else 
				Enregistrer(Sda.all.suivant, Destination, Masque, Eth);
			end if;
		end if;
	end Enregistrer;

-- Cle_presente permet de vérifier si une clé est présente ou non dans une liste chainée 
-- Pour cela, on parcours la liste et si on trouve la clé souhaitée alors on renvoie True sinon False

	function Destination_Presente (Sda : in T_Cache ; Destination : in T_Destination) return Boolean is
	
	begin
		if Est_Vide(Sda) then 
			return False;
		else
			if Sda.all.Destination = Destination then 
				return True;
			else 
				return Destination_Presente(Sda.all.Suivant, Destination);
			end if;
		end if;		
	end Destination_Presente;


-- Supprimer permet de supprimer la clé et sa donnée dans une liste
-- On vérifie que la liste contient bien la clé sinon on renvoie une exeption
-- Si la clé est présente alors on parcours la liste jusqu'à arriver à la cellule contenant la clé voulue 
-- On supprime ce terme en affectant à la sda son terme suivant 
-- On free la Sda pour éviter les pertes de paquets
-- On affecte à Sda la valeur de la sda suivant stockée précedement

	procedure Supprimer (Sda : in out T_Cache ; Destination : in T_Destination) is
	Sda_bis : T_Cache;

	begin

		if not Est_Vide(Sda) then 

			if Sda.all.Destination = Destination then 
				Sda_bis := Sda.Suivant;
				Free(Sda);
				Sda := Sda_bis;
			else 
				Supprimer(Sda.Suivant, Destination);
			end if; 
		else
			raise Cle_Absente_Exception;
		end if;

	end Supprimer;


	procedure Vider (Sda : in out T_Cache) is
		I : Integer;
	    Index : Integer;
	    A_Detruire : T_Cache;
	    Curseur : T_Cache;
	begin
		I := Taille(Sda);
		for Indice in reverse 0..I loop
			if Indice = 0 then -- suppression au début ?
				if Sda = null then
					null;
				else
					A_Detruire := Sda;
					Sda := Sda.all.Suivant;
					Free (A_Detruire);
				end if;
			else
				-- Trouver le (I-1)eme élément
				Index := 0;
				Curseur := Sda;
				while Curseur /= null and then Index < Indice - 1 loop
					Curseur := Curseur.all.Suivant;
					Index := Index + 1;
				end loop;

				-- Supprimer l"élément
				if Curseur = null or else Curseur.all.Suivant = null then
					null;
				else
					A_Detruire := Curseur.all.Suivant;
					Curseur.all.Suivant := A_Detruire.all.Suivant;
					Free (A_Detruire);
				end if;

			end if;
		end loop;
	end Vider;

end Cache;
