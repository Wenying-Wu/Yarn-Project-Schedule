-- Name: Wenying Wu
-- Date: Oct 9 2020

-- This database describes the knitting Project schedule from easy to hard 
-- help people to find the suitable knitting projects and yarns according to their capability
-- (Note: The code is unaligned in the text file, the code will be aligned when upload this text file in ed)

DROP table Project_Yarn CASCADE;
DROP table Yarn_Colour CASCADE;
DROP table Project CASCADE;
DROP table Yarn CASCADE;
DROP table Colour CASCADE;
DROP Table Fiber CASCADE;
DROP Table Designer CASCADE;


Create table Designer
(
	DesignerID			integer		UNIQUE,
	Designer_Name		char(10)	NOT NULL,
	Phone_Number		char(10),
	Email				TEXT,
	
	CONSTRAINT DesignerPK PRIMARY KEY (DesignerID),

	CONSTRAINT Designer_Designer_Name CHECK (Designer_Name IN('John', 'Ann', 'Jenny', 'Bruce'))
);

Create table Fiber
(

	Fiber		   		char(10)	UNIQUE,
	Fiber_Type			char(10),	
	Region 				char(15),

    CONSTRAINT FiberPK PRIMARY KEY (Fiber),

	CONSTRAINT Fiber_Fiber CHECK (Fiber IN('Alpaca', 'Raffia', 'Wool', 'Acrylic')),
	CONSTRAINT Fiber_Fiber_Type CHECK (Fiber_Type IN('Natural', 'Artificial')),
	CONSTRAINT Fiber_Region CHECK (Region IN('New Zealand', 'Japan', 'Australia', 'China'))   
);


Create table Colour
(
	ColourID			integer		UNIQUE,
	Colour_Name			char(20)	NOT NULL,	
	Colour_Family 		Char(10)	NOT NULL,

    CONSTRAINT ColourPK PRIMARY KEY (ColourID),

	CONSTRAINT Colour_ColourID CHECK ((ColourID >= 300) AND (ColourID <= 350)),	
	CONSTRAINT Colour_Colour_Name CHECK (Colour_Name IN('Pure Black', 'Midnight Blue', 'Dusty Blue', 'Cosmic Latte', 'Cream', 'Khaki', 'Bisque')),
	CONSTRAINT Colour_Colour_Family CHECK (Colour_Family IN('Black', 'Blue', 'Beige'))

);


Create table Yarn
(	
	YarnID				integer UNIQUE,
	Yarn_Name			TEXT	NOT NULL,	
	Price				integer,
	Yard				integer,
	Quantity			integer,
	Weight				TEXT,
	Fiber				char(10),

	CONSTRAINT YarnPK PRIMARY KEY (YarnID),
   	CONSTRAINT YarnFK FOREIGN KEY (Fiber) REFERENCES Fiber
		ON DELETE RESTRICT
		ON UPDATE CASCADE,

	CONSTRAINT Yarn_YarnID CHECK ((YarnID >= 1000) AND (YarnID <= 1500)),	
	CONSTRAINT Yarn_Price CHECK ((Price > 0) AND (Price <= 30)),
	CONSTRAINT Yarn_Quantity CHECK ((Quantity >= 50) AND (Quantity <= 200))
);


Create table Project
(
	ProjectID			integer,
	Project_Name		TEXT,
	DesignerID			integer,
	Time_Need			integer,
	Prerequisite		integer null,
	
	CONSTRAINT ProjectPK PRIMARY KEY (ProjectID),
	CONSTRAINT ProjectFK FOREIGN KEY (DesignerID) REFERENCES Designer
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	CONSTRAINT FK FOREIGN KEY (Prerequisite) REFERENCES Project (ProjectID)
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
	CONSTRAINT Project_ProjectID CHECK ((ProjectID >= 1) AND (ProjectID <= 6)),
	CONSTRAINT Project_Time_Need CHECK ((Time_Need >= 0) AND (Time_Need <= 35))
);


Create table Yarn_Colour
(
	YarnID				integer,
	ColourID			integer,

    	CONSTRAINT Yarn_ColourPK PRIMARY KEY (YarnID, ColourID),
CONSTRAINT Yarn_ColourFK_Yarn FOREIGN KEY (YarnID) REFERENCES Yarn 
		ON DELETE RESTRICT
		ON UPDATE CASCADE,
   	CONSTRAINT Yarn_ColourFK_Colour FOREIGN KEY (ColourID) REFERENCES Colour
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);


Create table Project_Yarn
(
	ProjectID			integer,
	YarnID				integer,

	CONSTRAINT Project_YarnPK PRIMARY KEY (ProjectID, YarnID),

	CONSTRAINT Project_YarnFK_Project FOREIGN KEY (ProjectID) REFERENCES Project,
	CONSTRAINT Project_YarnFK_Yarn FOREIGN KEY (YarnID) REFERENCES Yarn 
		ON DELETE RESTRICT
		ON UPDATE CASCADE
);


CREATE VIEW Designer_Project AS
    select DesignerID, Designer_Name as Designer, Project_Name as Project                    
    from  Designer natural join Project
    order by DesignerID;


-- Designer
Insert INTO Designer VALUES(374, 'John', 6104337060, 'John77@gmail.com');
Insert INTO Designer VALUES(399, 'Ann', 6104278859, 'Ann.knit@hotmail.com');
Insert INTO Designer VALUES(385, 'Jenny', 6147998327, 'Jenny0776@gmail.com');
Insert INTO Designer VALUES(370, 'Bruce', 6128849754, 'Bruce3785@gmail.com');

-- Fiber
Insert INTO Fiber VALUES('Alpaca', 'Natural', 'New Zealand');
Insert INTO Fiber VALUES('Raffia', 'Natural', 'Japan');
Insert INTO Fiber VALUES('Wool', 'Natural', 'Australia');
Insert INTO Fiber VALUES('Acrylic', 'Artificial', 'China');

-- Colour
Insert INTO Colour VALUES('310', 'Pure Black', 'Black');
Insert INTO Colour VALUES('320', 'Midnight Blue', 'Blue');
Insert INTO Colour VALUES('321', 'Dusty Blue', 'Blue');
Insert INTO Colour VALUES('330', 'Cosmic Latte', 'Beige');
Insert INTO Colour VALUES('331', 'Cream', 'Beige');
Insert INTO Colour VALUES('332', 'Khaki', 'Beige');
Insert INTO Colour VALUES('333', 'Bisque', 'Beige');

-- Yarn
Insert INTO Yarn VALUES(1070, 'Simple Alpaca Aran', 30, 246, 100, 'Sport', 'Alpaca');
Insert INTO Yarn VALUES(1171, 'Ra-Ra Raffia', 20, 273, 100, 'Worsted', 'Raffia');
Insert INTO Yarn VALUES(1271, 'Crazy Sexy Aool', 24, 87, 200, 'Super Chunky', 'Wool');
Insert INTO Yarn VALUES(1364, 'Soft Merino', 8, 218, 50, 'Fingering', 'Wool');
Insert INTO Yarn VALUES(1473, 'Brava Sport Aarn', 5, 273, 100, 'Sport', 'Acrylic');

-- Project
Insert INTO Project VALUES(1, 'Loop weave', 370, 5, null);
Insert INTO Project VALUES(2, 'Shopping Bag', 399, 6, 1);
Insert INTO Project VALUES(3, 'Cute sock', 374, 9, 2);
Insert INTO Project VALUES(4, 'Blanket', 385,  15, 3);
Insert INTO Project VALUES(5, 'Chullo hats', 370, 29, 4);
Insert INTO Project VALUES(6, 'Taylor Sweater', 385, 35, 5);

-- Project_Yarn
Insert INTO Project_Yarn VALUES(1, 1070);
Insert INTO Project_Yarn VALUES(2, 1171);
Insert INTO Project_Yarn VALUES(3, 1070);
Insert INTO Project_Yarn VALUES(3, 1171);
Insert INTO Project_Yarn VALUES(4, 1171);
Insert INTO Project_Yarn VALUES(4, 1473);
Insert INTO Project_Yarn VALUES(5, 1271);
Insert INTO Project_Yarn VALUES(5, 1473);
Insert INTO Project_Yarn VALUES(6, 1070);
Insert INTO Project_Yarn VALUES(6, 1271);
Insert INTO Project_Yarn VALUES(6, 1473);

-- Yarn_Colour
Insert INTO Yarn_Colour VALUES(1070, 310);
Insert INTO Yarn_Colour VALUES(1070, 320);
Insert INTO Yarn_Colour VALUES(1070, 321);
Insert INTO Yarn_Colour VALUES(1171, 320);
Insert INTO Yarn_Colour VALUES(1171, 331);
Insert INTO Yarn_Colour VALUES(1171, 332);
Insert INTO Yarn_Colour VALUES(1271, 331);
Insert INTO Yarn_Colour VALUES(1271, 332);
Insert INTO Yarn_Colour VALUES(1364, 310);
Insert INTO Yarn_Colour VALUES(1364, 331);
Insert INTO Yarn_Colour VALUES(1473, 331);
Insert INTO Yarn_Colour VALUES(1473, 333);

