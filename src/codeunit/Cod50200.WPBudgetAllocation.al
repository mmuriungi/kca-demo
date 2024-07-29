codeunit 50200 "WP Budget Allocation"
{

    trigger OnRun()
    begin
    end;

    var
        GLBudgetName: Record "G/L Budget Name";
        GLSetup: Record "General Ledger Setup";
        ItemBudgetName: Record "Item Budget Name";
        WorkplanAct: Record "Workplan Activities";

    procedure AutoAllocatePurch(var Rec: Record "Temp Budget Alloc Purch")
    var
        Budget: Record "Item Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "Item Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record "Item";
    begin

        //check if the date inserted as the start date is greater than the end date
        IF (Rec."Start Date" > Rec."End Date") THEN BEGIN
            ERROR('Ending Date must BE greater than or equal to start date');
        END;
        /*Get the new date selected by the user first*/
        NewDate := Rec."Start Date";
        /*Get the period*/
        IF Rec."Period Type" = Rec."Period Type"::Daily THEN BEGIN
            Period := 'D';
        END
        ELSE
            IF Rec."Period Type" = Rec."Period Type"::Weekly THEN BEGIN
                Period := 'W';
            END
            ELSE
                IF Rec."Period Type" = Rec."Period Type"::Monthly THEN BEGIN
                    Period := 'M';
                END
                ELSE
                    IF Rec."Period Type" = Rec."Period Type"::Quarterly THEN BEGIN
                        Period := 'Q';
                    END
                    ELSE BEGIN
                        Period := 'Y';
                    END;
        /*Initiate the loop*/
        WHILE NewDate <= Rec."End Date"
          DO BEGIN
            IntC := IntC + 1;
            NewDate := CALCDATE('1' + Period, NewDate);
        END;
        /*Number of times to divide amount has been identified*/
        /*Get the amount and get the amount per period identified*/

        Amnt := Rec.Amount / IntC;

        /*Get the entry number*/
        GLBudgetEntry.RESET;
        IF GLBudgetEntry.FIND('+') THEN BEGIN
            EntryNo := GLBudgetEntry."Entry No.";
        END
        ELSE BEGIN
            EntryNo := 0;
        END;
        EntryNo := EntryNo + 1;
        /*Check if the user wishes to overwrite the details already in the system*/
        IF Rec.Overwrite = TRUE THEN BEGIN
            GLBudgetEntry.RESET;
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name", Rec.Name);
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Item No.", Rec."Item No");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 1 Code", Rec."Budget Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 2 Code", Rec."Budget Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 3 Code", Rec."Budget Dimension 3 Code");
            IF GLBudgetEntry.FIND('-') THEN BEGIN
                GLBudgetEntry.DELETEALL;
            END;
        END;
        /*Reset the new date*/
        NewDate := Rec."Start Date";
        /*Initiate the loop to save the details into the table*/
        WHILE NewDate <= Rec."End Date"
          DO BEGIN
            GLBudgetEntry.INIT;
            GLBudgetEntry."Entry No." := EntryNo;

            GLBudgetEntry."Analysis Area" := GLBudgetEntry."Analysis Area"::Purchase;

            GLBudgetEntry."Budget Name" := Rec.Name;
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Name");

            GLBudgetEntry."Item No." := Rec."Item No";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Item No.");
            GL.RESET;
            GL.GET(Rec."Item No");
            /*
                  Forced to comment out by TChibo
            //    GLBudgetEntry."Item G/L Sales Account":=GL."Item G/L Sales Account";
            //    GLBudgetEntry."Item G/L Cost Account":=GLBudgetEntry."Item G/L Cost Account";
            */
            GLBudgetEntry."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 1 Code");

            GLBudgetEntry."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 2 Code");

            GLBudgetEntry."Budget Dimension 1 Code" := Rec."Budget Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 1 Code");

            GLBudgetEntry."Budget Dimension 2 Code" := Rec."Budget Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 2 Code");

            GLBudgetEntry."Budget Dimension 3 Code" := Rec."Budget Dimension 3 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 3 Code");

            GLBudgetEntry.Date := NewDate;


            IF Rec."Show As" = Rec."Show As"::Quantity THEN BEGIN
                GLBudgetEntry."Sales Amount" := Amnt;
            END
            ELSE
                IF Rec."Show As" = Rec."Show As"::"Cost Amount" THEN BEGIN
                    GLBudgetEntry.Quantity := Amnt;
                END
                ELSE
                    IF Rec."Show As" = Rec."Show As"::"Cost Amount" THEN BEGIN
                        GLBudgetEntry."Cost Amount" := Amnt;
                    END;

            GLBudgetEntry."User ID" := USERID;

            GLBudgetEntry.INSERT(TRUE);
            NewDate := CALCDATE('1' + Period, NewDate);
            EntryNo := EntryNo + 1;
        END;
        Rec.Processed := TRUE;
        Rec."User ID" := USERID;
        Rec.MODIFY;
        MESSAGE('Budgetary Allocation Complete');
        Rec.DELETE;

    end;

    procedure AutoAllocateSale(var Rec: Record "Temp Budget Alloc Sale")
    var
        Budget: Record "Item Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "Item Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record "Item";
    begin

        //check if the date inserted as the start date is greater than the end date
        IF (Rec."Start Date" > Rec."End Date") THEN BEGIN
            ERROR('Ending Date must BE greater than or equal to start date');
        END;

        /*Get the new date selected by the user first*/
        NewDate := Rec."Start Date";
        /*Get the period*/
        IF Rec."Period Type" = Rec."Period Type"::Daily THEN BEGIN
            Period := 'D';
        END
        ELSE
            IF Rec."Period Type" = Rec."Period Type"::Weekly THEN BEGIN
                Period := 'W';
            END
            ELSE
                IF Rec."Period Type" = Rec."Period Type"::Monthly THEN BEGIN
                    Period := 'M';
                END
                ELSE
                    IF Rec."Period Type" = Rec."Period Type"::Quarterly THEN BEGIN
                        Period := 'Q';
                    END
                    ELSE BEGIN
                        Period := 'Y';
                    END;
        /*Initiate the loop*/
        WHILE NewDate <= Rec."End Date"
          DO BEGIN
            IntC := IntC + 1;
            NewDate := CALCDATE('1' + Period, NewDate);
        END;
        /*Number of times to divide amount has been identified*/
        /*Get the amount and get the amount per period identified*/

        Amnt := Rec.Amount / IntC;

        /*Get the entry number*/
        GLBudgetEntry.RESET;
        IF GLBudgetEntry.FIND('+') THEN BEGIN
            EntryNo := GLBudgetEntry."Entry No.";
        END
        ELSE BEGIN
            EntryNo := 0;
        END;
        EntryNo := EntryNo + 1;
        /*Check if the user wishes to overwrite the details already in the system*/
        IF Rec.Overwrite = TRUE THEN BEGIN
            GLBudgetEntry.RESET;
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name", Rec.Name);
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Item No.", Rec."Item No");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 1 Code", Rec."Budget Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 2 Code", Rec."Budget Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 3 Code", Rec."Budget Dimension 3 Code");
            IF GLBudgetEntry.FIND('-') THEN BEGIN
                GLBudgetEntry.DELETEALL;
            END;
        END;
        /*Reset the new date*/
        NewDate := Rec."Start Date";
        /*Initiate the loop to save the details into the table*/
        WHILE NewDate <= Rec."End Date"
          DO BEGIN
            GLBudgetEntry.INIT;
            GLBudgetEntry."Entry No." := EntryNo;

            GLBudgetEntry."Analysis Area" := Rec."Analysis Area"::Sales;

            GLBudgetEntry."Budget Name" := Rec.Name;
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Name");

            GLBudgetEntry."Item No." := Rec."Item No";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Item No.");
            GL.RESET;
            GL.GET(Rec."Item No");
            /*
                  Forced to comment out by TChibo
            //    GLBudgetEntry."Item G/L Sales Account":=GL."Item G/L Sales Account";
            //    GLBudgetEntry."Item G/L Cost Account":=GLBudgetEntry."Item G/L Cost Account";
            */
            GLBudgetEntry."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 1 Code");

            GLBudgetEntry."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 2 Code");

            GLBudgetEntry."Budget Dimension 1 Code" := Rec."Budget Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 1 Code");

            GLBudgetEntry."Budget Dimension 2 Code" := Rec."Budget Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 2 Code");

            GLBudgetEntry."Budget Dimension 3 Code" := Rec."Budget Dimension 3 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 3 Code");

            GLBudgetEntry.Date := NewDate;


            IF Rec."Show As" = Rec."Show As"::"Sales Amount" THEN BEGIN
                GLBudgetEntry."Sales Amount" := Amnt;
            END
            ELSE
                IF Rec."Show As" = Rec."Show As"::Quantity THEN BEGIN
                    GLBudgetEntry.Quantity := Amnt;
                END
                ELSE
                    IF Rec."Show As" = Rec."Show As"::COGS THEN BEGIN
                        GLBudgetEntry."Cost Amount" := Amnt;
                    END;

            GLBudgetEntry."User ID" := USERID;

            GLBudgetEntry.INSERT;

            NewDate := CALCDATE('1' + Period, NewDate);
            EntryNo := EntryNo + 1;
        END;
        Rec.Processed := TRUE;
        Rec."User ID" := USERID;
        Rec.MODIFY;
        MESSAGE('Budgetary Allocation Complete');
        Rec.DELETE;

    end;

    procedure AutoAllocateGL(var Rec: Record "Temp Budget Alloc G/L")
    var
        Budget: Record "G/L Budget Name";
        DimVal: Record "Dimension Value";
        GLBudgetEntry: Record "G/L Budget Entry";
        IntC: Integer;
        NewDate: Date;
        Period: Text[30];
        Amnt: Decimal;
        EntryNo: Integer;
        GL: Record "G/L Account";
    begin

        //check if the date inserted as the start date is greater than the end date
        IF (Rec."Start Date" > Rec."End Date") THEN BEGIN
            ERROR('Ending Date must BE greater than or equal to start date');
        END;

        IF Rec."Type of Entry" = Rec."Type of Entry"::" " THEN BEGIN
            ERROR('Type Of Entry must not be blank in Line no.' + FORMAT(Rec."Line No."));
        END;
        /*Get the new date selected by the user first*/
        NewDate := Rec."Start Date";
        /*Get the period*/
        IF Rec."Period Type" = Rec."Period Type"::Daily THEN BEGIN
            Period := 'D';
        END
        ELSE
            IF Rec."Period Type" = Rec."Period Type"::Weekly THEN BEGIN
                Period := 'W';
            END
            ELSE
                IF Rec."Period Type" = Rec."Period Type"::Monthly THEN BEGIN
                    Period := 'M';
                END
                ELSE
                    IF Rec."Period Type" = Rec."Period Type"::Quarterly THEN BEGIN
                        Period := 'Q';
                    END
                    ELSE BEGIN
                        Period := 'Y';
                    END;
        /*Initiate the loop*/
        WHILE NewDate <= Rec."End Date"
          DO BEGIN
            IntC := IntC + 1;
            NewDate := CALCDATE('1' + Period, NewDate);
        END;
        /*Number of times to divide amount has been identified*/
        /*Get the amount and get the amount per period identified*/

        Amnt := Rec.Amount / IntC;

        /*Get the entry number*/
        GLBudgetEntry.RESET;
        IF GLBudgetEntry.FIND('+') THEN BEGIN
            EntryNo := GLBudgetEntry."Entry No.";
        END
        ELSE BEGIN
            EntryNo := 0;
        END;
        EntryNo := EntryNo + 1;
        /*Check if the user wishes to overwrite the details already in the system*/
        IF Rec.Overwrite = TRUE THEN BEGIN
            GLBudgetEntry.RESET;
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name", Rec.Name);
            GLBudgetEntry.SETRANGE(GLBudgetEntry."G/L Account No.", Rec."G/L Account");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code", Rec."Global Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Business Unit Code", Rec."Business Unit");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 1 Code", Rec."Budget Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 2 Code", Rec."Budget Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 3 Code", Rec."Budget Dimension 3 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 4 Code", Rec."Budget Dimension 4 Code");
            //GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 5 Code", "Budget Dimension 5 Code");
            //GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 6 Code", "Budget Dimension 6 Code");
            IF GLBudgetEntry.FIND('-') THEN BEGIN
                GLBudgetEntry.DELETEALL;
            END;
        END;
        /*Reset the new date*/
        NewDate := Rec."Start Date";
        /*Initiate the loop to save the details into the table*/
        WHILE NewDate <= Rec."End Date"
          DO BEGIN
            GLBudgetEntry.INIT;
            GLBudgetEntry."Entry No." := EntryNo;

            GLBudgetEntry."Budget Name" := Rec.Name;
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Name");

            GLBudgetEntry."G/L Account No." := Rec."G/L Account";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."G/L Account No.");

            GLBudgetEntry."Global Dimension 1 Code" := Rec."Global Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 1 Code");

            GLBudgetEntry."Global Dimension 2 Code" := Rec."Global Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 2 Code");

            GLBudgetEntry."Business Unit Code" := Rec."Business Unit";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Business Unit Code");

            GLBudgetEntry."Budget Dimension 1 Code" := Rec."Budget Dimension 1 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 1 Code");

            GLBudgetEntry."Budget Dimension 2 Code" := Rec."Budget Dimension 2 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 2 Code");

            GLBudgetEntry."Budget Dimension 3 Code" := Rec."Budget Dimension 3 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 3 Code");

            GLBudgetEntry."Budget Dimension 4 Code" := Rec."Budget Dimension 4 Code";
            GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 4 Code");

            //GLBudgetEntry."Budget Dimension 5 Code" := "Budget Dimension 5 Code";
            //GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 5 Code");

            //GLBudgetEntry."Budget Dimension 6 Code" := "Budget Dimension 6 Code";
            //GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 6 Code");

            GLBudgetEntry.Date := NewDate;
            IF Rec."Type of Entry" = Rec."Type of Entry"::Debit THEN BEGIN
                GLBudgetEntry.Amount := Amnt;
            END
            ELSE
                IF Rec."Type of Entry" = Rec."Type of Entry"::Credit THEN BEGIN
                    GLBudgetEntry.Amount := -Amnt;
                END;
            GLBudgetEntry."User ID" := USERID;

            GLBudgetEntry.INSERT;

            //Added to Ensure that Respective Dimension is added to the Dimension buffer
            GLSetup.GET;
            GLBudgetName.GET(GLBudgetEntry."Budget Name");
            UpdateDim(GLSetup."Global Dimension 1 Code", Rec."Global Dimension 1 Code", GLBudgetEntry);
            UpdateDim(GLSetup."Global Dimension 2 Code", Rec."Global Dimension 2 Code", GLBudgetEntry);
            UpdateDim(GLBudgetName."Budget Dimension 1 Code", Rec."Budget Dimension 1 Code", GLBudgetEntry);
            UpdateDim(GLBudgetName."Budget Dimension 2 Code", Rec."Budget Dimension 2 Code", GLBudgetEntry);
            UpdateDim(GLBudgetName."Budget Dimension 3 Code", Rec."Budget Dimension 3 Code", GLBudgetEntry);
            UpdateDim(GLBudgetName."Budget Dimension 4 Code", Rec."Budget Dimension 4 Code", GLBudgetEntry);
            //End Added items

            NewDate := CALCDATE('1' + Period, NewDate);
            EntryNo := EntryNo + 1;
        END;
        Rec.Processed := TRUE;
        Rec."User ID" := USERID;
        Rec.MODIFY;

        MESSAGE('Budgetary Allocation Complete');
        Rec.DELETE;

    end;

    procedure UpdateDim(DimCode: Code[20]; DimValueCode: Code[20]; Rec: Record "G/L Budget Entry")
    begin
        IF DimCode = '' THEN
            EXIT;
        /*
        WITH GLBudgetDim DO BEGIN
          IF GET(Rec."Entry No.",DimCode) THEN
            DELETE;
          IF DimValueCode <> '' THEN BEGIN
            INIT;
            "Entry No." := Rec."Entry No.";
            "Dimension Code" := DimCode;
            "Dimension Value Code" := DimValueCode;
            INSERT;
          END;
        END;
        */

    end;

    procedure CreateBudgetFromWorkplan(WorkBugAlloc: Record "Procur. Plan Budget Allocation")
    var
        GLBudgetEntry: Record "G/L Budget Entry";
        ItemBudgetEntry: Record "Item Budget Entry";
        WorkplanEntry: Record "Workplan Entry";
        EntryNo: Integer;
        Items: Record "Item";
    begin

        //Get the entry number
        GLBudgetEntry.RESET;
        IF GLBudgetEntry.FIND('+') THEN BEGIN
            EntryNo := GLBudgetEntry."Entry No.";
        END
        ELSE BEGIN
            EntryNo := 0;
        END;

        EntryNo := EntryNo + 1;

        //Check if the user wishes to overwrite the details already in the system}
        IF WorkBugAlloc.Overwrite = TRUE THEN BEGIN
            GLBudgetEntry.RESET;
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Name", WorkBugAlloc."Current G/L Budget");
            //GLBudgetEntry.SETRANGE(GLBudgetEntry."G/L Account No.","G/L Account");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 1 Code", WorkBugAlloc."Global Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Global Dimension 2 Code", WorkBugAlloc."Global Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Business Unit Code", WorkBugAlloc."Business Unit");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 1 Code", WorkBugAlloc."Budget Dimension 1 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 2 Code", WorkBugAlloc."Budget Dimension 2 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 3 Code", WorkBugAlloc."Budget Dimension 3 Code");
            GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 4 Code", WorkBugAlloc."Budget Dimension 4 Code");
            // GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 5 Code", "Budget Dimension 5 Code");
            // GLBudgetEntry.SETRANGE(GLBudgetEntry."Budget Dimension 6 Code", "Budget Dimension 6 Code");
            IF GLBudgetEntry.FIND('-') THEN BEGIN
                GLBudgetEntry.DELETEALL;
            END;
        END;
        //*************************************************************************************************************
        //FOR G/L ACCOUNT
        WorkplanEntry.RESET;
        //WorkplanEntry.SETRANGE(WorkplanEntry."Workplan Code",Name);
        WorkplanEntry.SETRANGE(WorkplanEntry."Account Type", WorkplanEntry."Account Type"::"G/L Account");
        WorkplanEntry.SETRANGE(WorkplanEntry."Processed to Budget", FALSE); //Added DW. not to Re-Transfer Amount already processed
        IF (WorkBugAlloc."Start Date" <> 0D) AND (WorkBugAlloc."End Date" <> 0D) THEN WorkplanEntry.SETRANGE(WorkplanEntry.Date, WorkBugAlloc."Start Date", WorkBugAlloc."End Date");
        IF WorkplanEntry.FIND('-') THEN BEGIN
            REPEAT
                GLBudgetEntry.INIT;
                GLBudgetEntry."Entry No." := EntryNo;

                GLBudgetEntry."Budget Name" := WorkBugAlloc."Current G/L Budget";
                GLBudgetEntry.VALIDATE("Budget Name");
                //GLBudgetEntry."Processed from Workplan" := TRUE;
                GLBudgetEntry."G/L Account No." := WorkplanEntry."G/L Account No.";
                GLBudgetEntry.TESTFIELD("G/L Account No.");
                GLBudgetEntry.VALIDATE(GLBudgetEntry."G/L Account No.");


                GLBudgetEntry."Global Dimension 1 Code" := WorkplanEntry."Global Dimension 1 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 1 Code");

                GLBudgetEntry."Global Dimension 2 Code" := WorkplanEntry."Global Dimension 2 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 2 Code");

                GLBudgetEntry."Business Unit Code" := WorkplanEntry."Business Unit Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Business Unit Code");

                GLBudgetEntry."Budget Dimension 1 Code" := WorkplanEntry."Budget Dimension 1 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 1 Code");

                GLBudgetEntry."Budget Dimension 2 Code" := WorkplanEntry."Budget Dimension 2 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 2 Code");

                GLBudgetEntry."Budget Dimension 3 Code" := WorkplanEntry."Budget Dimension 3 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 3 Code");

                GLBudgetEntry."Budget Dimension 4 Code" := WorkplanEntry."Budget Dimension 4 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 4 Code");

                //GLBudgetEntry."Budget Dimension 5 Code" := WorkplanEntry."Budget Dimension 5 Code";
                //GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 5 Code");

                //GLBudgetEntry."Budget Dimension 6 Code" := WorkplanEntry."Budget Dimension 6 Code";
                //GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 6 Code");


                //Get Description from Workplan Activities
                WorkplanAct.RESET;
                WorkplanAct.SETRANGE(WorkplanAct."Activity Code", WorkplanEntry."Activity Code");
                IF WorkplanAct.FIND('-') THEN BEGIN
                    GLBudgetEntry.Description := WorkplanAct."Activity Description";
                END ELSE BEGIN
                    GLBudgetEntry.Description := WorkplanEntry.Description;
                END;

                GLBudgetEntry.Date := WorkplanEntry.Date;
                //GLBudgetEntry.WorkplanCode := WorkplanEntry."Activity Code";
                GLBudgetEntry.Amount := WorkplanEntry.Amount;
                GLBudgetEntry."User ID" := USERID;

                GLBudgetEntry.INSERT;

                //Added DW: to mark entry as already processed
                WorkplanEntry."Processed to Budget" := TRUE;
                WorkplanEntry.VALIDATE(WorkplanEntry."Processed to Budget");

                //Added to Ensure that Respective Dimension is added to the Dimension buffer
                GLSetup.GET;
                GLBudgetName.GET(GLBudgetEntry."Budget Name");
                UpdateDim(GLSetup."Global Dimension 1 Code", WorkBugAlloc."Global Dimension 1 Code", GLBudgetEntry);
                UpdateDim(GLSetup."Global Dimension 2 Code", WorkBugAlloc."Global Dimension 2 Code", GLBudgetEntry);
                UpdateDim(GLBudgetName."Budget Dimension 1 Code", WorkBugAlloc."Budget Dimension 1 Code", GLBudgetEntry);
                UpdateDim(GLBudgetName."Budget Dimension 2 Code", WorkBugAlloc."Budget Dimension 2 Code", GLBudgetEntry);
                UpdateDim(GLBudgetName."Budget Dimension 3 Code", WorkBugAlloc."Budget Dimension 3 Code", GLBudgetEntry);
                UpdateDim(GLBudgetName."Budget Dimension 4 Code", WorkBugAlloc."Budget Dimension 4 Code", GLBudgetEntry);
                //End Added items

                EntryNo += 1;
            UNTIL WorkplanEntry.NEXT = 0;
        END;

        //ITEM BUDGETS
        //Get the entry number
        ItemBudgetEntry.RESET;
        IF ItemBudgetEntry.FIND('+') THEN BEGIN
            EntryNo := ItemBudgetEntry."Entry No.";
        END
        ELSE BEGIN
            EntryNo := 0;
        END;
        EntryNo := EntryNo + 1;

        //Check if the user wishes to overwrite the details already in the system
        IF WorkBugAlloc.Overwrite = TRUE THEN BEGIN
            ItemBudgetEntry.RESET;
            ItemBudgetEntry.SETRANGE(ItemBudgetEntry."Budget Name", WorkBugAlloc."Current Item Budget");
            ItemBudgetEntry.SETRANGE(ItemBudgetEntry."Global Dimension 1 Code", WorkBugAlloc."Global Dimension 1 Code");
            ItemBudgetEntry.SETRANGE(ItemBudgetEntry."Global Dimension 2 Code", WorkBugAlloc."Global Dimension 2 Code");
            ItemBudgetEntry.SETRANGE(ItemBudgetEntry."Budget Dimension 1 Code", WorkBugAlloc."Budget Dimension 1 Code");
            ItemBudgetEntry.SETRANGE(ItemBudgetEntry."Budget Dimension 2 Code", WorkBugAlloc."Budget Dimension 2 Code");
            ItemBudgetEntry.SETRANGE(ItemBudgetEntry."Budget Dimension 3 Code", WorkBugAlloc."Budget Dimension 3 Code");
            IF ItemBudgetEntry.FIND('-') THEN BEGIN
                ItemBudgetEntry.DELETEALL;
            END;
        END;

        //*******************************************************************************************************************
        //FOR ITEMS


        WorkplanEntry.RESET;
        //WorkplanEntry.SETRANGE(WorkplanEntry."Workplan Code",Name);
        WorkplanEntry.SETRANGE(WorkplanEntry."Processed to Budget", FALSE); //Added DW: Not to reprocess amounts already Processed
        WorkplanEntry.SETRANGE(WorkplanEntry."Account Type", WorkplanEntry."Account Type"::Item);
        IF (WorkBugAlloc."Start Date" <> 0D) AND (WorkBugAlloc."End Date" <> 0D) THEN WorkplanEntry.SETRANGE(WorkplanEntry.Date, WorkBugAlloc."Start Date", WorkBugAlloc."End Date");
        IF WorkplanEntry.FIND('-') THEN BEGIN
            REPEAT

                //Get the entry number
                ItemBudgetEntry.RESET;
                IF ItemBudgetEntry.FIND('+') THEN BEGIN
                    EntryNo := ItemBudgetEntry."Entry No.";
                END
                ELSE BEGIN
                    EntryNo := 0;
                END;
                EntryNo := EntryNo + 1;

                ItemBudgetEntry.INIT;
                ItemBudgetEntry."Entry No." := EntryNo;

                ItemBudgetEntry."Analysis Area" := ItemBudgetEntry."Analysis Area"::Purchase;

                ItemBudgetEntry."Budget Name" := WorkBugAlloc."Current Item Budget";
                ItemBudgetEntry.VALIDATE(ItemBudgetEntry."Budget Name");

                ItemBudgetEntry."Item No." := WorkplanEntry."G/L Account No.";
                ItemBudgetEntry.VALIDATE(ItemBudgetEntry."Item No.");

                Items.RESET;
                Items.GET(ItemBudgetEntry."Item No.");

                ItemBudgetEntry."Global Dimension 1 Code" := WorkplanEntry."Global Dimension 1 Code";
                ItemBudgetEntry.VALIDATE(ItemBudgetEntry."Global Dimension 1 Code");

                ItemBudgetEntry."Global Dimension 2 Code" := WorkplanEntry."Global Dimension 2 Code";
                ItemBudgetEntry.VALIDATE(ItemBudgetEntry."Global Dimension 2 Code");

                ItemBudgetEntry."Budget Dimension 1 Code" := WorkplanEntry."Budget Dimension 1 Code";
                ItemBudgetEntry.VALIDATE(ItemBudgetEntry."Budget Dimension 1 Code");

                ItemBudgetEntry."Budget Dimension 2 Code" := WorkplanEntry."Budget Dimension 2 Code";
                ItemBudgetEntry.VALIDATE(ItemBudgetEntry."Budget Dimension 2 Code");

                ItemBudgetEntry."Budget Dimension 3 Code" := WorkplanEntry."Budget Dimension 3 Code";
                ItemBudgetEntry.VALIDATE(ItemBudgetEntry."Budget Dimension 3 Code");

                //Get Description from Workplan Activities
                WorkplanAct.RESET;
                WorkplanAct.SETRANGE(WorkplanAct."Activity Code", WorkplanEntry."Activity Code");
                IF WorkplanAct.FIND('-') THEN BEGIN
                    ItemBudgetEntry.Description := WorkplanAct."Activity Description";
                END ELSE BEGIN
                    ItemBudgetEntry.Description := WorkplanEntry.Description;
                END;

                ItemBudgetEntry.Date := WorkplanEntry.Date;
                ItemBudgetEntry.Quantity := WorkplanEntry.Quantity;
                ItemBudgetEntry."Cost Amount" := WorkplanEntry.Amount;

                ItemBudgetEntry."User ID" := USERID;

                ItemBudgetEntry.INSERT(TRUE);

                //Added DW: to mark entry as already processed
                WorkplanEntry."Processed to Budget" := TRUE;
                WorkplanEntry.VALIDATE(WorkplanEntry."Processed to Budget");
                //WorkplanEntry.modify;

                //Added to Ensure that Respective Dimension is added to the Dimension buffer
                GLSetup.GET;
                //        ItemBudgetName.GET(ItemBudgetName."Analysis Area"=ItemBudgetName."Analysis Area"::Purchase,ItemBudgetEntry."Budget Name");
                UpdateItemDim(GLSetup."Global Dimension 1 Code", WorkBugAlloc."Global Dimension 1 Code", ItemBudgetEntry);
                UpdateItemDim(GLSetup."Global Dimension 2 Code", WorkBugAlloc."Global Dimension 2 Code", ItemBudgetEntry);
                UpdateItemDim(GLBudgetName."Budget Dimension 1 Code", WorkBugAlloc."Budget Dimension 1 Code", ItemBudgetEntry);
                UpdateItemDim(GLBudgetName."Budget Dimension 2 Code", WorkBugAlloc."Budget Dimension 2 Code", ItemBudgetEntry);
                UpdateItemDim(GLBudgetName."Budget Dimension 3 Code", WorkBugAlloc."Budget Dimension 3 Code", ItemBudgetEntry);
                UpdateItemDim(GLBudgetName."Budget Dimension 4 Code", WorkBugAlloc."Budget Dimension 4 Code", ItemBudgetEntry);
                //End Added items

                EntryNo += 1;
                //Insert also into GL Budget Entries ************************************************************************************

                //Get the entry number
                GLBudgetEntry.RESET;
                IF GLBudgetEntry.FIND('+') THEN BEGIN
                    EntryNo := GLBudgetEntry."Entry No.";
                END
                ELSE BEGIN
                    EntryNo := 0;
                END;

                EntryNo := EntryNo + 1;

                GLBudgetEntry.INIT;
                GLBudgetEntry."Entry No." := EntryNo;

                GLBudgetEntry."Budget Name" := WorkBugAlloc."Current G/L Budget";
                GLBudgetEntry.VALIDATE("Budget Name");

                Items.GET(WorkplanEntry."G/L Account No.");
                //Items.TESTFIELD(Items."Item G/L Budget Account");

                //GLBudgetEntry."G/L Account No." := Items."Item G/L Budget Account";

                GLBudgetEntry.TESTFIELD("G/L Account No.");
                GLBudgetEntry.VALIDATE(GLBudgetEntry."G/L Account No.");
                //GLBudgetEntry."Processed from Workplan" := TRUE;

                GLBudgetEntry."Global Dimension 1 Code" := WorkplanEntry."Global Dimension 1 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 1 Code");

                GLBudgetEntry."Global Dimension 2 Code" := WorkplanEntry."Global Dimension 2 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Global Dimension 2 Code");

                GLBudgetEntry."Business Unit Code" := WorkplanEntry."Business Unit Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Business Unit Code");

                GLBudgetEntry."Budget Dimension 1 Code" := WorkplanEntry."Budget Dimension 1 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 1 Code");

                GLBudgetEntry."Budget Dimension 2 Code" := WorkplanEntry."Budget Dimension 2 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 2 Code");

                GLBudgetEntry."Budget Dimension 3 Code" := WorkplanEntry."Budget Dimension 3 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 3 Code");

                GLBudgetEntry."Budget Dimension 4 Code" := WorkplanEntry."Budget Dimension 4 Code";
                GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 4 Code");

                // GLBudgetEntry."Budget Dimension 5 Code" := WorkplanEntry."Budget Dimension 5 Code";
                // GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 5 Code");

                // GLBudgetEntry."Budget Dimension 6 Code" := WorkplanEntry."Budget Dimension 6 Code";
                // GLBudgetEntry.VALIDATE(GLBudgetEntry."Budget Dimension 6 Code");

                //Get Description from Workplan Activities
                WorkplanAct.RESET;
                WorkplanAct.SETRANGE(WorkplanAct."Activity Code", WorkplanEntry."Activity Code");
                IF WorkplanAct.FIND('-') THEN BEGIN
                    GLBudgetEntry.Description := WorkplanAct."Activity Description";
                END ELSE BEGIN
                    GLBudgetEntry.Description := WorkplanEntry.Description;
                END;

                GLBudgetEntry.Date := WorkplanEntry.Date;
                //GLBudgetEntry.WorkplanCode := WorkplanEntry."Workplan Code";
                //GLBudgetEntry.VALIDATE(GLBudgetEntry.WorkplanCode);
                GLBudgetEntry.Amount := WorkplanEntry.Amount;
                GLBudgetEntry."User ID" := USERID;

                GLBudgetEntry.INSERT;

                //Added DW: to mark entry as already processed
                WorkplanEntry."Processed to Budget" := TRUE;
                WorkplanEntry.VALIDATE(WorkplanEntry."Processed to Budget");

                //Added to Ensure that Respective Dimension is added to the Dimension buffer
                GLSetup.GET;
                GLBudgetName.GET(GLBudgetEntry."Budget Name");
                UpdateDim(GLSetup."Global Dimension 1 Code", WorkBugAlloc."Global Dimension 1 Code", GLBudgetEntry);
                UpdateDim(GLSetup."Global Dimension 2 Code", WorkBugAlloc."Global Dimension 2 Code", GLBudgetEntry);
                UpdateDim(GLBudgetName."Budget Dimension 1 Code", WorkBugAlloc."Budget Dimension 1 Code", GLBudgetEntry);
                UpdateDim(GLBudgetName."Budget Dimension 2 Code", WorkBugAlloc."Budget Dimension 2 Code", GLBudgetEntry);
                UpdateDim(GLBudgetName."Budget Dimension 3 Code", WorkBugAlloc."Budget Dimension 3 Code", GLBudgetEntry);
                UpdateDim(GLBudgetName."Budget Dimension 4 Code", WorkBugAlloc."Budget Dimension 4 Code", GLBudgetEntry);
            //End Added items

            //Insert also into GL Budget Entries ************************************************************************************
            UNTIL WorkplanEntry.NEXT = 0;
        END;
        MESSAGE('Budget Entries Created Successfully');
    end;

    procedure UpdateItemDim(DimCode: Code[20]; DimValueCode: Code[20]; Rec: Record "Item Budget Entry")
    var
        ItemBudgetDim: Record "Item Budget Dimension";
    begin
        IF DimCode = '' THEN
            EXIT;
        /*
        WITH ItemBudgetDim DO BEGIN
          IF GET(Rec."Entry No.",DimCode) THEN
            DELETE;
          IF DimValueCode <> '' THEN BEGIN
            INIT;
            "Entry No." := Rec."Entry No.";
            "Dimension Code" := DimCode;
            "Dimension Value Code" := DimValueCode;
            INSERT;
          END;
        END;
        */

    end;
}

