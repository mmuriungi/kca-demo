page 54484 "Lab Treamtnet Form"
{
    Caption = 'Lab Treamtnet Form';
    PageType = Card;
    SourceTable = "HMS-Treatment Form Laboratory";



    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("Treatment No2."; Rec."Treatment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Treatment No. field.', Comment = '%';
                }
                field("Treatment No."; Rec."Treatment No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Treatment No. field.', Comment = '%';
                }
                field("Laboratory Test Package Code"; Rec."Laboratory Test Package Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Laboratory Test Package Code field.', Comment = '%';
                }
                field("Laboratory Test Package Name"; Rec."Laboratory Test Package Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Laboratory Test Package Name field.', Comment = '%';
                }
                // field("Date Due"; Rec."Date Due")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Date Due field.', Comment = '%';
                // }
                // field(Results; Rec.Results)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Results field.', Comment = '%';
                // }
                // field(Status; Rec.Status)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Status field.', Comment = '%';
                // }
                // field(Diagnosis; Rec.Diagnosis)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Diagnosis field.', Comment = '%';
                // }
                // field(Specimen; Rec.Specimen)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Specimen field.', Comment = '%';
                // }
                // field(Test; Rec.Test)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Test field.', Comment = '%';
                // }
                // field("Send to lab"; Rec."Send to lab")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the value of the Send to lab field.', Comment = '%';
                // }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Comments field.', Comment = '%';
                }
                field("Patient No."; Rec."Patient No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Patient No. field.', Comment = '%';
                }
                field(Range; rec.Range)
                {
                    ApplicationArea = Basic, Suite;
                    // Update the HideListFields variable when this field changes
                    trigger OnValidate()
                    begin
                        HideListFields := Rec.Range;
                        UpdateListPart();
                    end;
                }
            }
            part(labtest; "HMS-Setup Lab Test Specimen SF")
            {
                ApplicationArea = All;
                subPageLink = "Treatment No." = field("Treatment No."), "Laboratory Test Package Code" = field("Laboratory Test Package Code");
            }
            field(Comments1; Rec.Comments)
            {
                MultiLine = true;
                ApplicationArea = Basic, Suite;
                ShowCaption = false;
            }
        }

    }
    trigger OnOpenPage()
    begin

        Message('Specimens for test are yet to be populated');
        HideListFields := Rec.Range;
        GenerateSpecimenRecords(Rec."Treatment No.", Rec."Laboratory Test Package Code");



    end;

    procedure GenerateSpecimenRecords(treatmentNo: Code[20]; labtestPac: Code[20])
    var
        AllSpecimenList: Record AllSpecimentList;

    begin
        // Debug message to indicate the start of the procedure
        //  Message('Insertion process started successfully');

        // Filter the AllSpecimenList based on the Laboratory Test Package Code
        AllSpecimenList.SetRange("Lab Test", Rec."Laboratory Test Package Code");
        TestSpecimen.Reset();

        // Set the filter on TestSpecimen
        TestSpecimen.SetRange("Treatment No.", treatmentNo);
        TestSpecimen.SetRange("Laboratory Test Package Code", labtestPac);
        if TestSpecimen.Find('-') then begin
            TestSpecimen.DeleteAll();
        end;
        // Check if there are records in the AllSpecimenList
        if AllSpecimenList.FindSet() then begin
            repeat
                // Debug message to indicate the loop start
                //Message('Insertion loop started successfully');



                // Debug message to indicate a new record is being created
                //Message('Creating new TestSpecimen record');

                // Initialize the TestSpecimen record
                TestSpecimen.Init();

                // Assign values from AllSpecimenList to TestSpecimen
                TestSpecimen."Treatment No." := treatmentNo;
                TestSpecimen."Laboratory Test Package Code" := labtestPac;
                TestSpecimen."specimen code" := AllSpecimenList."specimen code";
                TestSpecimen."Lab Test" := AllSpecimenList."Lab Test";
                TestSpecimen."Specimen Name" := AllSpecimenList."Specimen Name";
                TestSpecimen."Lab Test Description" := AllSpecimenList."Lab Test Description";
                TestSpecimen.unit := AllSpecimenList.unit;
                TestSpecimen."Minimum Value" := AllSpecimenList."Minimum Value";
                TestSpecimen."Maximum Value" := AllSpecimenList."Maximum Value";
                TestSpecimen.Flag := AllSpecimenList.Flag;
                TestSpecimen.Result := '';
                TestSpecimen."Patient No." := Rec."Patient No.";
                TestSpecimen."Line No" := TestSpecimen."Line No" + 10;


                // Insert the new TestSpecimen record
                TestSpecimen.Insert(true);

            // Debug message to confirm insertion
            // Message('Inserted specimen code %1 for Lab Test %2', TestSpecimen."specimen code", TestSpecimen."Lab Test");



            // Insert the new TestSpecimen record


            until AllSpecimenList.Next() = 0;
        end else begin
            // Debug message if no records are found in AllSpecimenList
            Message('No specimens found for Lab Test %1', Rec."Laboratory Test Package Code");
        end;
    end;



    procedure UpdateListPart()
    var
        labTestPage: Page "HMS-Setup Lab Test Specimen SF";
    begin
        if CurrPage.labtest.PAGE.Editable then begin
            labTestPage := CurrPage.labtest.PAGE;
            labTestPage.SetHideListFields(HideListFields);
        end;
    end;

    procedure GetLastEntryNo(): Integer;
    var
        FindRecordManagement: Codeunit "Find Record Management";
    begin
        exit(FindRecordManagement.GetLastEntryIntFieldValue(TestSpecimen, TestSpecimen.FieldNo("Line No")))
    end;

    var
        HideListFields: Boolean;
        TestSpecimen: Record "HMS-Setup Test Specimen";

}