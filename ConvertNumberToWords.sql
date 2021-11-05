USE [CreditQuest_KE]
GO

/****** Object:  UserDefinedFunction [dbo].[Number_To_Words]    Script Date: 1/15/2019 2:29:06 PM ******/
DROP FUNCTION [dbo].[Number_To_Words]
GO

/****** Object:  UserDefinedFunction [dbo].[Number_To_Words]    Script Date: 1/15/2019 2:29:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE FUNCTION [dbo].[Number_To_Words] (
            @Input Numeric (38) -- Input number with as many as 18 digits
        ) RETURNS VARCHAR(8000) 

        /*
        * Converts a integer number as large as 34 digits into the 
        * equivalent words.  The first letter is capitalized.
        *
        *SOFGEN
        ****************************************************************/
        AS BEGIN
        Declare @Number Numeric(38,0)
        
        --Yonah: 27th July.
                                --Handle Negative numbers
                                declare @isNegavite varchar(30) = ''
                                IF @Input < 0 
                                                BEGIN
                                                                set @isNegavite = 'Negative '
                                                END
        
                                set @Input = ABS(@Input)
                                set @Number = @Input

        Declare @Cents as int
        set @Cents = 100*Convert(money,(@Input - convert(Numeric(38,3),@Number)))
        DECLARE @inputNumber VARCHAR(38)
        DECLARE @NumbersTable TABLE (number CHAR(2), word VARCHAR(10))
        DECLARE @outputString VARCHAR(8000)
        DECLARE @length INT
        DECLARE @counter INT
        DECLARE @loops INT
        DECLARE @position INT
        DECLARE @chunk CHAR(3) -- for chunks of 3 numbers
        DECLARE @tensones CHAR(2)
        DECLARE @hundreds CHAR(1)
        DECLARE @tens CHAR(1)
        DECLARE @ones CHAR(1)

        IF @Number = 0 Return 'Zero'

        -- initialize the variables
        SELECT @inputNumber = CONVERT(varchar(38), @Number)
             , @outputString = ''
             , @counter = 1
        SELECT @length   = LEN(@inputNumber)
             , @position = LEN(@inputNumber) - 2
             , @loops    = LEN(@inputNumber)/3

        -- make sure there is an extra loop added for the remaining numbers
        IF LEN(@inputNumber) % 3 <> 0 SET @loops = @loops + 1

        -- insert data for the numbers and words
        INSERT INTO @NumbersTable   SELECT '00', ''
            UNION ALL SELECT '01', 'One'      UNION ALL SELECT '02', 'Two'
            UNION ALL SELECT '03', 'Three'    UNION ALL SELECT '04', 'Four'
            UNION ALL SELECT '05', 'Five'     UNION ALL SELECT '06', 'Six'
            UNION ALL SELECT '07', 'Seven'    UNION ALL SELECT '08', 'Eight'
            UNION ALL SELECT '09', 'Nine'     UNION ALL SELECT '10', 'Ten'
            UNION ALL SELECT '11', 'Eleven'   UNION ALL SELECT '12', 'Twelve'
            UNION ALL SELECT '13', 'Thirteen' UNION ALL SELECT '14', 'Fourteen'
            UNION ALL SELECT '15', 'Fifteen'  UNION ALL SELECT '16', 'Sixteen'
            UNION ALL SELECT '17', 'Seventeen' UNION ALL SELECT '18', 'Eighteen'
            UNION ALL SELECT '19', 'Nineteen' UNION ALL SELECT '20', 'Twenty'
            UNION ALL SELECT '30', 'Thirty'   UNION ALL SELECT '40', 'Forty'
            UNION ALL SELECT '50', 'Fifty'    UNION ALL SELECT '60', 'Sixty'
            UNION ALL SELECT '70', 'Seventy'  UNION ALL SELECT '80', 'Eighty'
            UNION ALL SELECT '90', 'Ninety'   

        WHILE @counter <= @loops BEGIN

            -- get chunks of 3 numbers at a time, padded with leading zeros
            SET @chunk = RIGHT('000' + SUBSTRING(@inputNumber, @position, 3), 3)

            IF @chunk <> '000' BEGIN
                SELECT @tensones = SUBSTRING(@chunk, 2, 2)
                     , @hundreds = SUBSTRING(@chunk, 1, 1)
                     , @tens = SUBSTRING(@chunk, 2, 1)
                     , @ones = SUBSTRING(@chunk, 3, 1)

                -- If twenty or less, use the word directly from @NumbersTable
                IF CONVERT(INT, @tensones) <= 20 OR @Ones='0' BEGIN
                    SET @outputString = (SELECT word 
                                              FROM @NumbersTable 
                                              WHERE @tensones = number)
                           + CASE @counter WHEN 1 THEN '' -- No name
                               WHEN 2 THEN ' Thousand ' WHEN 3 THEN ' Million '
                               WHEN 4 THEN ' Billion '  WHEN 5 THEN ' Trillion '
                               WHEN 6 THEN ' Quadrillion ' WHEN 7 THEN ' Quintillion '
                               WHEN 8 THEN ' Sextillion '  WHEN 9 THEN ' Septillion '
                               WHEN 10 THEN ' Octillion '  WHEN 11 THEN ' Nonillion '
                               WHEN 12 THEN ' Decillion '  WHEN 13 THEN ' Undecillion '
                               ELSE '' END
                                       + @outputString
                    END
                 ELSE BEGIN -- break down the ones and the tens separately

                     SET @outputString = ' ' 
                                    + (SELECT word 
                                            FROM @NumbersTable 
                                            WHERE @tens + '0' = number)
                                     + '-'
                                     + (SELECT word 
                                            FROM @NumbersTable 
                                            WHERE '0'+ @ones = number)
                           + CASE @counter WHEN 1 THEN '' -- No name
                               WHEN 2 THEN ' Thousand ' WHEN 3 THEN ' Million '
                               WHEN 4 THEN ' Billion '  WHEN 5 THEN ' Trillion '
                               WHEN 6 THEN ' Quadrillion ' WHEN 7 THEN ' Quintillion '
                               WHEN 8 THEN ' Sextillion '  WHEN 9 THEN ' Septillion '
                               WHEN 10 THEN ' Octillion '  WHEN 11 THEN ' Nonillion '
                               WHEN 12 THEN ' Decillion '   WHEN 13 THEN ' Undecillion '
                               ELSE '' END
                                    + @outputString
                END

                -- now get the hundreds
                IF @hundreds <> '0' BEGIN
                    SET @outputString  = (SELECT word 
                                              FROM @NumbersTable 
                                              WHERE '0' + @hundreds = number)
                                        + ' Hundred ' 
                                        + @outputString
                END
            END

            SELECT @counter = @counter + 1
                 , @position = @position - 3

        END

        -- Remove any double spaces
        SET @outputString = LTRIM(RTRIM(REPLACE(@outputString, '  ', ' ')))
        SET @outputstring = UPPER(LEFT(@outputstring, 1)) + SUBSTRING(@outputstring, 2, 8000)

        RETURN CONCAT(@isNegavite,'',@outputString)   -- return the result
                                
        END




GO

