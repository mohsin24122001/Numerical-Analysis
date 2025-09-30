classdef ComplexNumber
    properties
        Real
        Imag
    end

    methods
        function obj = ComplexNumber(real, imag)
            obj.Real = real;
            obj.Imag = imag;
        end
        
        function result = plus(obj1, obj2)
            real_part = obj1.Real + obj2.Real;
            imag_part = obj1.Imag + obj2.Imag;
            result = ComplexNumber(real_part, imag_part);
        end
        
        function result = minus(obj1, obj2)
            real_part = obj1.Real - obj2.Real;
            imag_part = obj1.Imag - obj2.Imag;
            result = ComplexNumber(real_part, imag_part);
        end
        
        function result = mtimes(obj1, obj2)
            real_part = obj1.Real * obj2.Real - obj1.Imag * obj2.Imag;
            imag_part = obj1.Real * obj2.Imag + obj1.Imag * obj2.Real;
            result = ComplexNumber(real_part, imag_part);
        end
        
        function result = conjugate(obj)
            result = ComplexNumber(obj.Real, -obj.Imag);
        end
        
        %String Representation Method for complex numbers
        function str = char(obj)
            if obj.Imag >= 0
                str = sprintf('%g + %gi', obj.Real, obj.Imag);
            else
                str = sprintf('%g - %gi', obj.Real, abs(obj.Imag));
            end
        end

        % Tuple Representation method for complex numbers
        % function str = char(obj)
        %     str = sprintf('(%g, %g)', obj.Real, obj.Imag);
        % end


        %Polar Form Representation methods for complex numbers
        % function str = char(obj)
        %     magnitude = sqrt(obj.Real^2 + obj.Imag^2);
        %     angle = atan2(obj.Imag, obj.Real);
        %     str = sprintf('%.2f∠%.2f rad', magnitude, angle);
        % end

    end
end

