// Generated by Haxe 4.2.2
#ifndef INCLUDED_Byter
#define INCLUDED_Byter

#ifndef HXCPP_H
#include <hxcpp.h>
#endif

HX_DECLARE_CLASS0(Byter)



class HXCPP_CLASS_ATTRIBUTES Byter_obj : public ::hx::Object
{
	public:
		typedef ::hx::Object super;
		typedef Byter_obj OBJ_;
		Byter_obj();

	public:
		enum { _hx_ClassId = 0x4509e1a6 };

		void __construct();
		inline void *operator new(size_t inSize, bool inContainer=false,const char *inName="Byter")
			{ return ::hx::Object::operator new(inSize,inContainer,inName); }
		inline void *operator new(size_t inSize, int extra)
			{ return ::hx::Object::operator new(inSize+extra,false,"Byter"); }

		inline static ::hx::ObjectPtr< Byter_obj > __new() {
			::hx::ObjectPtr< Byter_obj > __this = new Byter_obj();
			__this->__construct();
			return __this;
		}

		inline static ::hx::ObjectPtr< Byter_obj > __alloc(::hx::Ctx *_hx_ctx) {
			Byter_obj *__this = (Byter_obj*)(::hx::Ctx::alloc(_hx_ctx, sizeof(Byter_obj), false, "Byter"));
			*(void **)__this = Byter_obj::_hx_vtable;
			return __this;
		}

		static void * _hx_vtable;
		static Dynamic __CreateEmpty();
		static Dynamic __Create(::hx::DynamicArray inArgs);
		//~Byter_obj();

		HX_DO_RTTI_ALL;
		static bool __GetStatic(const ::String &inString, Dynamic &outValue, ::hx::PropertyAccess inCallProp);
		static bool __SetStatic(const ::String &inString, Dynamic &ioValue, ::hx::PropertyAccess inCallProp);
		static void __register();
		bool _hx_isInstanceOf(int inClassId);
		::String __ToString() const { return HX_("Byter",4a,78,c5,50); }

		static void __boot();
		static bool bin;
		static ::String inPath;
		static ::String outPath;
		static int exitCode;
		static void main();
		static ::Dynamic main_dyn();

		static void argProcess();
		static ::Dynamic argProcess_dyn();

		static ::String opcode(::String instruction);
		static ::Dynamic opcode_dyn();

		static ::String numFormat(::String num,::hx::Null< int >  padding);
		static ::Dynamic numFormat_dyn();

		static ::String bin2hex(::String bin);
		static ::Dynamic bin2hex_dyn();

		static ::String removeComment(::String text);
		static ::Dynamic removeComment_dyn();

		static void error(::String msg,int lineNumber);
		static ::Dynamic error_dyn();

};


#endif /* INCLUDED_Byter */ 