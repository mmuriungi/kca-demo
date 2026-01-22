table 50103 "Disposal Plan Table Header"
{

    fields
    {
        field(1; "No."; Code[10])
        {

            trigger OnValidate()
            begin

                IF "No." <> xRec."No." THEN BEGIN
                    GetInvtsetup;
                    NoSeriesMgt.TestManual(Invtsetup."Item Nos.");
                    "No. Series" := '';

                END;
            end;
        }
        field(2; Year; Date)
        {
        }
        field(3; Description; Text[30])
        {
        }
        field(4; "Shortcut dimension 1 code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(5; "Shortcut dimension 2 code"; Code[10])
        {
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(6; "No. Series"; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(9; "Disposal Method"; Code[20])
        {
            TableRelation = "Disposal Methods"."Disposal Methods";

            trigger OnValidate()
            begin
                dispoline.RESET;
                dispoline.SETRANGE(dispoline."Ref. No.", "No.");
                IF dispoline.FIND('-') THEN BEGIN
                    dispoline."Disposal Method" := "Disposal Method";
                    dispoline.MODIFY;
                END;
            end;
        }
        field(50000; "Disposal Methodc"; Option)
        {
            OptionCaption = ' ,Open tender,public auction,Trade-in,Transfer,Dumping';
            OptionMembers = " ","Open tender","public auction","Trade-in",Transfer,Dumping;
        }
        field(50001; Status; Option)
        {
            Editable = true;
            OptionCaption = 'Open,Pending Approval,Approved,Rejected,Posted';
            OptionMembers = Open,"Pending Approval",Approved,Rejected,Posted;
        }
        field(50002; "Disposal Status"; Option)
        {
            OptionMembers = " Planning",CEO,"Tender Committee","Disposal implementation",Disposed;
        }
        field(50003; Date; Date)
        {
        }
        field(50004; "No series"; Code[20])
        {
        }
        field(50005; "Ref No"; Code[30])
        {
        }
        field(50006; "Responsibility Center"; Code[20])
        {
            TableRelation = "Responsibility Center".Code;
        }
        field(50007; "Planned Date"; Date)
        {
        }
        field(50009; "Disposal Year"; Code[20])
        {
            NotBlank = false;
            TableRelation = "Disposal Period".Code;

            trigger OnValidate()
            begin
                DisposalPeriod.RESET;
                DisposalPeriod.SETRANGE(DisposalPeriod.Code, "Disposal Year");
                IF DisposalPeriod.FIND('-') THEN
                    "Disposal Description" := DisposalPeriod.Description;
            end;
        }
        field(50010; "Disposal Description"; Text[30])
        {
        }
        field(50011; "Date of Purchase"; Date)
        {
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
        key(Key2; "Ref No")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin

        //GENERATE NEW NUMBER FOR THE DOCUMENT
        IF "No." = '' THEN BEGIN
            PurchSetup.GET;
            //PurchSetup.TESTFIELD(PurchSetup."Disposal Process Nos.");
            //NoSeriesMgt.InitSeries(PurchSetup."Disposal Process Nos.",xRec."No series",0D, "No.","No series");
        END;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        Invtsetup: Record "Inventory Setup";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        PurchSetup: Record "Purchases & Payables Setup";
        DisposalPeriod: Record "Disposal Period";
        dispoline: Record "Disposal plan table lines";

    procedure GetInvtsetup()
    begin
    end;
}

