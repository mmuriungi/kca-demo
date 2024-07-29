page 54976 "HMS-Treatment Form Laboratory"
{
    PageType = List;
    Editable = true;
    InsertAllowed = true;
    SourceTable = "HMS-Treatment Form Laboratory";
    CardPageId = "Lab Treamtnet Form";

    layout
    {
        area(content)
        {
            repeater(rep)
            {
                field("Laboratory Test Package Code"; Rec."Laboratory Test Package Code")
                {
                    ApplicationArea = All;
                    // MultiLine = true;
                }
                field("Laboratory Test Package Name"; Rec."Laboratory Test Package Name")
                {
                    ApplicationArea = All;
                    // MultiLine = true;
                }
                field("Date Due"; Rec."Date Due")
                {
                    ApplicationArea = All;
                    // MultiLine = true;
                }
                field(Results; Rec.Results)
                {
                    ApplicationArea = All;
                    // MultiLine = true;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = all;
                    // MultiLine = true;
                }

                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
            }

        }
    }

    actions
    {
        area(processing)
        {
            action("&Request Tests")
            {
                Caption = '&Request Tests';
                ApplicationArea = All;

                trigger OnAction()
                begin
                    /*Send the request now?*/


                    IF CONFIRM('Send Laboratory Test Request Now?', FALSE) = TRUE THEN BEGIN
                        HMSSetup.RESET;
                        HMSSetup.GET();
                        NewNo := NoSeriesMgt.GetNextNo(HMSSetup."Lab Test Request Nos", 0D, TRUE);
                        TreatmentHeader.RESET;
                        TreatmentHeader.GET(Rec."Treatment No.");
                        LabHeader.RESET;
                        LabHeader.INIT;
                        LabHeader."Laboratory No." := NewNo;
                        LabHeader."Laboratory Date" := TODAY;
                        LabHeader."Laboratory Time" := TIME;
                        LabHeader."Patient No." := TreatmentHeader."Patient No.";
                        LabHeader."Student No." := TreatmentHeader."Student No.";
                        LabHeader."Employee No." := TreatmentHeader."Employee No.";
                        LabHeader."Relative No." := TreatmentHeader."Relative No.";
                        LabHeader."Request Area" := LabHeader."Request Area"::Doctor;
                        LabHeader."Link Type" := 'Treatment';
                        LabHeader."Link No." := TreatmentHeader."Treatment No.";
                        labheader2.RESET;
                        labheader2.SETRANGE(labheader2."Link No.", TreatmentHeader."Treatment No.");
                        IF labheader2.FIND('-') THEN BEGIN
                            IF CONFIRM('Record already exist,Confirm Continue?') THEN LabHeader.INSERT;
                        END
                        ELSE BEGIN
                            LabHeader.INSERT;
                        END;
                        DocLabRequestLines.RESET;
                        DocLabRequestLines.SETRANGE(DocLabRequestLines."Treatment No.", Rec."Treatment No.");
                        DocLabRequestLines.SETRANGE(DocLabRequestLines.Status, DocLabRequestLines.Status::New);
                        IF DocLabRequestLines.FIND('-') THEN BEGIN
                            REPEAT
                                DocLabRequestLines.Status := DocLabRequestLines.Status::Forwarded;
                                DocLabRequestLines.MODIFY;
                                /*
                                 LabSpecimenSetup.RESET;
                                 LabSpecimenSetup.SETRANGE(LabSpecimenSetup.Test,DocLabRequestLines."Laboratory Test Package Code");
                                    IF LabSpecimenSetup.FIND('-') THEN BEGIN
                                     REPEAT
                                     */
                                LabTestLines.INIT;
                                LabTestLines."Laboratory No." := LabHeader."Laboratory No.";
                                //LabTestLines."Laboratory Test Code":=LabSpecimenSetup.Test;
                                LabTestLines."Laboratory Test Code" := DocLabRequestLines."Laboratory Test Package Code";
                                LabTestLines."Specimen Code" := LabSpecimenSetup."Specimen Name";
                                LabTestLines."Measuring Unit Code" := LabSpecimenSetup.unit;
                                //LabTestLines."Laboratory Test Name":=LabSpecimenSetup."Test Name";
                                LabTestLines."Laboratory Test Name" := DocLabRequestLines."Laboratory Test Package Name";

                                LabTestLines."Specimen Name" := LabSpecimenSetup."Specimen Name";
                                LabTestLines.INSERT;
                            //  UNTIL LabSpecimenSetup.NEXT=0;
                            // END;

                            /* DocLabRequestLines.reset;
                             DocLabRequestLines.SETRANGE(DocLabRequestLines."Laboratory Test Package Code",LabTestLines."Laboratory Test Code");

                             DocLabRequestLines.find('-') then begin
                               REPEAT
                                 LabTestLines.INIT;
                                // LabTestLines."Laboratory No.":=LabHeader."Laboratory No.";
                                 LabTestLines."Laboratory Test Code":=LabSpecimenSetup.Test;
                                 LabTestLines."Specimen Code":=LabSpecimenSetup.Specimen;
                                 LabTestLines."Measuring Unit Code":=LabSpecimenSetup."Measuring Unit";
                                 LabTestLines."Laboratory Test Name":=LabSpecimenSetup."Test Name";
                                 LabTestLines."Specimen Name":=LabSpecimenSetup."Specimen Name";
                                 LabTestLines.INSERT;
                              UNTIL LabSpecimenSetup.NEXT=0;
                             END;
                                  */
                            // DocLabRequestLines.Status:=DocLabRequestLines.Status::Forwarded;
                            //DocLabRequestLines.MODIFY;
                            UNTIL DocLabRequestLines.NEXT = 0;
                        END
                        ELSE BEGIN
                            ERROR('Nothing to Forward!');
                        END;


                        /*
                        TreatmentHeader.RESET;
                        TreatmentHeader.SETRANGE(TreatmentHeader."Treatment No.","Treatment No.");
                        IF TreatmentHeader.FIND('-') THEN
                           REPORT.RUN(39005793,TRUE,FALSE,TreatmentHeader);
                        */

                    END;

                end;
            }
            action(EDMS)
            {
                ApplicationArea = All;
                Caption = 'Attachments';
                Image = Attach;
                ToolTip = 'Add a file as an attachment. You can attach images as well as documents.';
                RunObject = Page "Document Attachment Details";
                RunPageLink = "No." = field("Treatment No.");
            }



        }
    }

    var
        LabHeader: Record "HMS-Laboratory Form Header";
        LabLine: Record "HMS-Laboratory Test Line";
        TreatmentHeader: Record "HMS-Treatment Form Header";
        TreatmentLine: Record "HMS-Treatment Form Laboratory";
        Tests: Record "HMS-Setup Lab Package Test";
        SpecimenList: Record "HMS-Setup Test Specimen";
        HMSSetup: Record "HMS-Setup";
        NoSeriesMgt: Codeunit 396;
        NewNo: Code[20];
        DocLabRequestLines: Record "HMS-Treatment Form Laboratory";
        LabTestLines: Record "HMS-Laboratory Test Line";
        Labsetup: Record "HMS-Setup Lab Test";
        LabSpecimenSetup: Record "HMS-Setup Test Specimen";
        labheader2: Record "HMS-Laboratory Form Header";
}

