report 50021 "Store Requisitions"
{
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/StoreRequisition - Backup.rdl';

    dataset
    {
        dataitem(DataItem1826; "PROC-Store Requistion Header")
        {
            DataItemTableView = SORTING("No.");
            RequestFilterFields = "No.";
            column(Store_Requistion_Header__No__; "No.")
            {
            }
            column(Store_Requistion_Header__Request_Description_; "Request Description")
            {
            }
            column(Store_Requistion_Header__Request_date_; "Request date")
            {
            }
            column(Store_Requistion_Header__Required_Date_; "Required Date")
            {
            }
            column(Store_Requistion_Header__Global_Dimension_1_Code_; "Global Dimension 1 Code")
            {
            }
            column(dept; dimVal.Name)
            {
            }
            column(Store_Requistion_Header__Function_Name_; "Function Name")
            {
            }
            column(Store_Requistion_Header__Budget_Center_Name_; "Budget Center Name")
            {
            }
            column(TIME_PRINTED_____FORMAT_TIME_; 'TIME PRINTED:' + FORMAT(TIME))
            {
                AutoFormatType = 1;
            }
            column(DATE_PRINTED_____FORMAT_TODAY_0_4_; 'DATE PRINTED:' + FORMAT(TODAY, 0, 4))
            {
                AutoFormatType = 1;
            }
            column(USERID; USERID)
            {
            }
            column(pics; info.Picture)
            {
            }
            column(ApprovalUserArr_3_; ApprovalUserArr[3])
            {
            }
            column(ApprovalDateArr_3_; ApprovalDateArr[3])
            {
            }
            column(Store_Requistion_Header__Store_Requistion_Header___Requester_ID_; "Requester ID")
            {
            }
            column(Store_RequistionCaption; Store_RequistionCaptionLbl)
            {
            }
            column(Store_Requistion_Header__No__Caption; FIELDCAPTION("No."))
            {
            }
            column(Store_Requistion_Header__Request_Description_Caption; FIELDCAPTION("Request Description"))
            {
            }
            column(Store_Requistion_Header__Request_date_Caption; FIELDCAPTION("Request date"))
            {
            }
            column(Store_Requistion_Header__Required_Date_Caption; FIELDCAPTION("Required Date"))
            {
            }
            column(Store_Requistion_Header__Global_Dimension_1_Code_Caption; FIELDCAPTION("Global Dimension 1 Code"))
            {
            }
            column(Store_Requistion_Header__Shortcut_Dimension_2_Code_Caption; FIELDCAPTION("Shortcut Dimension 2 Code"))
            {
            }
            column(Store_Requistion_Lines__No__Caption; FIELDCAPTION("No."))
            {
            }
            // column(Store_Requistion_Lines_DescriptionCaption;FIELDCAPTION(Description))
            // {
            // }
            // column(Store_Requistion_Lines_QuantityCaption;FIELDCAPTION(Quantity))
            // {
            // }
            column(UoMCaption; UoMCaptionLbl)
            {
            }
            column(Store_Requistion_Lines__Line_Amount_Caption; FIELDCAPTION("Amount"))
            {

            }

            // column(Store_Requistion_Lines__Unit_Cost_Caption;FIELDCAPTION(Unit))
            // {
            // }
            column(Date_Caption; Date_CaptionLbl)
            {
            }
            column(Name_Caption; Name_CaptionLbl)
            {
            }
            column(RecipientCaption; RecipientCaptionLbl)
            {
            }
            column(Printed_By_Caption; Printed_By_CaptionLbl)
            {
            }
            column(Name_Caption_Control1102755052; Name_Caption_Control1102755052Lbl)
            {
            }
            column(Date_Caption_Control1102755053; Date_Caption_Control1102755053Lbl)
            {
            }
            column(Signature_Caption; Signature_CaptionLbl)
            {
            }
            column(AuthorisationsCaption; AuthorisationsCaptionLbl)
            {
            }
            column(EmptyStringCaption; EmptyStringCaptionLbl)
            {
            }
            column(Signature_Caption_Control1102755000; Signature_Caption_Control1102755000Lbl)
            {
            }
            column(DepartmentName_PROCStoreRequistionHeader; "Department Name")
            {
            }
            dataitem(DataItem7187; "PROC-Store Requistion Lines")
            {
                DataItemLink = "Requistion No" = FIELD("No.");
                DataItemTableView = SORTING("Requistion No", "No.")
                                    ORDER(Ascending);
                column(seq; seq)
                {
                }
                column(Store_Requistion_Lines__No__; "No.")
                {
                }
                column(Store_Requistion_Lines_Description; Description)
                {
                }
                column(Issued; Quantity)
                {
                }
                column(Requested; "Quantity Requested")
                {
                }
                column(Store_Requistion_Lines__Unit_of_Measure_; "Unit of Measure")
                {
                }
                column(Store_Requistion_Lines__Line_Amount_; "Line Amount")
                {
                }
                column(Store_Requistion_Lines__Unit_Cost_; "Unit Cost")
                {
                }
                column(Store_Requistion_Lines_Requistion_No; "Requistion No")
                {
                }
                column(QtyRequested; "Quantity Requested")
                {
                }

                trigger OnAfterGetRecord()
                begin
                    seq := seq + 1;
                end;
            }
            dataitem(AppEntry; "Approval Entry")
            {
                DataItemLink = "Document No." = FIELD("No.");
                DataItemTableView = WHERE(Status = CONST(Approved));
                PrintOnlyIfDetail = true;
                column(SequenceNo_ApprovalEntry; AppEntry."Sequence No.")
                {
                }
                column(ApproverID_ApprovalEntry; AppEntry."Approver ID")
                {
                }
                column(LastDateTimeModified_ApprovalEntry; FORMAT(AppEntry."Last Date-Time Modified"))
                {
                }
                column(SenderID_ApprovalEntry; AppEntry."Sender ID")
                {
                }
                column(DateTimeSentforApproval_ApprovalEntry; format(AppEntry."Date-Time Sent for Approval"))
                {
                }
                dataitem(usrSetup; "User Setup")
                {
                    DataItemLink = "User ID" = FIELD("Approver ID");
                    //PrintOnlyIfDetail = true;
                    column(Signature_UserSetup; usrSetup."User Signature")
                    {
                    }
                    column(ApprovalDesignation_UserSetup; usrSetup."Approval Title")
                    {
                    }
                }

                trigger OnAfterGetRecord()
                begin
                    ApprovalEntry.RESET;
                    ApprovalEntry.SETRANGE(ApprovalEntry."Document No.", "Document No.");
                    ApprovalEntry.SETRANGE(ApprovalEntry."Document Type", ApprovalEntry."Document Type"::"Store Requisitions");
                    IF ApprovalEntry.FIND('-') THEN
                        REPEAT
                            ApprovalUserArr[ApprovalEntry."Sequence No."] := ApprovalEntry."Last Modified By ID";
                            ApprovalDateArr[ApprovalEntry."Sequence No."] := ApprovalEntry."Last Date-Time Modified";
                        UNTIL ApprovalEntry.NEXT = 0;
                    CLEAR(seq);

                end;
            }
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnInitReport()
    begin
        info.RESET;
        IF info.FIND('-') THEN BEGIN
            info.CALCFIELDS(info.Picture);
        END;
    end;

    var
        ApprovalEntry: Record 454;
        ApprovalUserArr: array[10] of Code[30];
        ApprovalDateArr: array[10] of DateTime;
        ArrCount: Integer;
        Store_RequistionCaptionLbl: Label 'Store Requistion';
        UoMCaptionLbl: Label 'UoM';
        Date_CaptionLbl: Label 'Date:';
        Name_CaptionLbl: Label 'Name:';
        RecipientCaptionLbl: Label 'Recipient';
        Printed_By_CaptionLbl: Label 'Printed By:';
        Name_Caption_Control1102755052Lbl: Label 'Name:';
        Date_Caption_Control1102755053Lbl: Label 'Date:';
        Signature_CaptionLbl: Label 'Signature:';
        AuthorisationsCaptionLbl: Label 'Authorisations';
        EmptyStringCaptionLbl: Label '================================================================================================================================================================================================';
        Signature_Caption_Control1102755000Lbl: Label 'Signature:';
        seq: Integer;
        dimVal: Record 349;
        info: Record 79;
}

