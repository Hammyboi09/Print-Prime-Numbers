DELIMITER #
CREATE PROCEDURE Get_Primes()
BEGIN
    DECLARE prime_str VARCHAR(10000) default NULL;
    DECLARE prime INT default 2;
    WHILE prime < 1001 DO
        SET @is_prime = TRUE;
        SET @num = 2;
        
        check_loop : LOOP
            IF @num = prime THEN
                LEAVE check_loop;
            END IF;
            IF MOD(prime, @num) = 0 THEN
                SET @is_prime = FALSE;
                LEAVE check_loop;
            END IF;

            SET @num = @num + 1;
            ITERATE check_loop;
        END LOOP check_loop;

        IF @is_prime = TRUE THEN
            IF prime_str IS NULL THEN
                SET prime_str = CONVERT(prime, CHAR(10));
            ELSE
                SET prime_str = CONCAT_WS("&", prime_str, CONVERT(prime, CHAR(10)));
            END IF;
        END IF;

        SET prime = prime + 1;
    END WHILE;
    SELECT prime_str;
END; #
DElIMITER ;

CALL Get_Primes()