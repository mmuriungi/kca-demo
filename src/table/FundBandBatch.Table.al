#pragma warning disable AA0005, AA0008, AA0018, AA0021, AA0072, AA0137, AA0201, AA0204, AA0206, AA0218, AA0228, AL0254, AL0424, AS0011, AW0006 // ForNAV settings
Table 78076 "Fund Band Batch"
{

    fields
    {
        field(1; "Document No."; Code[25])
        {
        }
        field(2; "Academic Year"; Code[20])
        {
            TableRelation = "ACA-Academic Year";
        }
        field(3; Remarks; Text[250])
        {
        }
        field(4; "Created By"; Code[50])
        {
        }
        field(5; "Created DateTime"; DateTime)
        {
        }
        field(6; "Student Count"; Integer)
        {
            CalcFormula = count("Funding Band Entries" where("Batch No." = field("Document No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(7; "No. Series"; Code[25])
        {
        }
        field(8; Close; Boolean)
        {
        }
        field(9; Archived; Boolean)
        {

            trigger OnValidate()
            begin
                if Rec.Archived then begin
                    "Archived By" := UserId;
                    "Archived DatetTime" := CurrentDatetime;

                    BandEntries.Reset;
                    BandEntries.SetRange("Batch No.", "Document No.");
                    if BandEntries.FindSet then begin
                        EntryCount := BandEntries.Count;
                        RemaninigEntryCount := BandEntries.Count;
                        prog.Open('#1######################################\' +
                          '#2######################################');
                        prog.Update(1, 'Entries to Archive: ' + Format(EntryCount));
                        repeat
                            BandEntries.Archived := true;
                            BandEntries.Modify();
                            prog.Update(2, 'Entries to Archive: ' + Format(RemaninigEntryCount));
                            RemaninigEntryCount := RemaninigEntryCount - 1;
                        until BandEntries.Next = 0;
                        prog.Close;
                    end;
                    Commit();
                end;
            end;
        }
        field(10; "Archived By"; Code[50])
        {
        }
        field(11; "Archived DatetTime"; DateTime)
        {
        }
        field(12; Semester; Code[25])
        {
            TableRelation = "ACA-Semesters".Code;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Academic Year", Semester)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }

    trigger OnInsert()
    begin
        if "Document No." = '' then begin
            AcaGenSetup.Get();
            AcaGenSetup.TestField("Fund Band Batch Nos");
            NoSeriesMgmt.InitSeries(AcaGenSetup."Fund Band Batch Nos", xRec."No. Series", 0D, Rec."Document No.", Rec."No. Series");
        end;
        "Created By" := UserId;
        "Created DateTime" := CurrentDatetime;
    end;

    var
        AcaGenSetup: Record "ACA-General Set-Up";
        NoSeriesMgmt: Codeunit NoSeriesManagement;
        BandEntries: Record "Funding Band Entries";
        EntryCount: Integer;
        prog: Dialog;
        RemaninigEntryCount: Integer;
}

