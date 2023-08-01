require "win32ole"
require "win32ole/property"

module OLE_Application
  include WIN32OLE::VARIANT
  attr_reader :lastargs

  # _ModelReference ActiveModelReference
  def ActiveModelReference
    ret = _getproperty(1610743948, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _DesignFile ActiveDesignFile
  def ActiveDesignFile
    ret = _getproperty(1610743949, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _Workspace ActiveWorkspace
  def ActiveWorkspace
    ret = _getproperty(1610743951, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR Version
  def Version
    ret = _getproperty(1610743957, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL IsAcademicVersion
  def IsAcademicVersion
    ret = _getproperty(1610743958, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL IsRegistered
  def IsRegistered
    ret = _getproperty(1610743959, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL IsSerialized
  def IsSerialized
    ret = _getproperty(1610743960, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CommandState CommandState
  def CommandState
    ret = _getproperty(1610743961, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CadInputQueue CadInputQueue
  def CadInputQueue
    ret = _getproperty(1610743962, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _Settings ActiveSettings
  def ActiveSettings
    ret = _getproperty(1610743966, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DISPATCH VBE
  def VBE
    ret = _getproperty(1610743967, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL IsCellLibraryAttached
  def IsCellLibraryAttached
    ret = _getproperty(1610743997, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Visible
  def Visible
    ret = _getproperty(1610743998, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CellLibrary AttachedCellLibrary
  def AttachedCellLibrary
    ret = _getproperty(1610744000, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR Caption
  def Caption
    ret = _getproperty(1610744028, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR FullName
  def FullName
    ret = _getproperty(1610744030, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR Name
  def Name
    ret = _getproperty(1610744031, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR Path
  def Path
    ret = _getproperty(1610744032, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT LeftPosition
  def LeftPosition
    ret = _getproperty(1610744033, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT TopPosition
  def TopPosition
    ret = _getproperty(1610744035, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT Height
  def Height
    ret = _getproperty(1610744037, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT Width
  def Width
    ret = _getproperty(1610744039, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR KeyinArguments
  def KeyinArguments
    ret = _getproperty(1610744044, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT CurrentGraphicGroup
  def CurrentGraphicGroup
    ret = _getproperty(1610744057, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL HasActiveDesignFile
  def HasActiveDesignFile
    ret = _getproperty(1610744063, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL HasActiveModelReference
  def HasActiveModelReference
    ret = _getproperty(1610744064, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _RasterManager RasterManager
  def RasterManager
    ret = _getproperty(1610744097, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _Bspline Bspline
  def Bspline
    ret = _getproperty(1610744124, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _StandardsCheckerController StandardsCheckerController
  def StandardsCheckerController
    ret = _getproperty(1610744227, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR UserName
  def UserName
    ret = _getproperty(1610744228, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ACSManager ACSManager
  def ACSManager
    ret = _getproperty(1610744235, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CursorInformation CursorInformation
  def CursorInformation
    ret = _getproperty(1610744236, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DISPATCH ExecutingVBProject
  def ExecutingVBProject
    ret = _getproperty(1610744237, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT ProcessID
  def ProcessID
    ret = _getproperty(1610744277, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _MessageCenter MessageCenter
  def MessageCenter
    ret = _getproperty(1610744281, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL IsProcessLocked
  def IsProcessLocked
    ret = _getproperty(1610744285, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Visible
  def Visible=(arg0)
    ret = _setproperty(1610743998, [arg0], [VT_BOOL])
    @lastargs = WIN32OLE::ARGV
  end

  # VOID Caption
  def Caption=(arg0)
    ret = _setproperty(1610744028, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
  end

  # VOID LeftPosition
  def LeftPosition=(arg0)
    ret = _setproperty(1610744033, [arg0], [VT_I4])
    @lastargs = WIN32OLE::ARGV
  end

  # VOID TopPosition
  def TopPosition=(arg0)
    ret = _setproperty(1610744035, [arg0], [VT_I4])
    @lastargs = WIN32OLE::ARGV
  end

  # VOID Height
  def Height=(arg0)
    ret = _setproperty(1610744037, [arg0], [VT_I4])
    @lastargs = WIN32OLE::ARGV
  end

  # VOID Width
  def Width=(arg0)
    ret = _setproperty(1610744039, [arg0], [VT_I4])
    @lastargs = WIN32OLE::ARGV
  end

  # VOID KeyinArguments
  def KeyinArguments=(arg0)
    ret = _setproperty(1610744044, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
  end

  # VOID IsProcessLocked
  def IsProcessLocked=(arg0)
    ret = _setproperty(1610744285, [arg0], [VT_BOOL])
    @lastargs = WIN32OLE::ARGV
  end

  # R8 Point2dMagnitudeSquared
  # method Point2dMagnitudeSquared
  #   Point2d arg0 --- Vector [IN]
  def Point2dMagnitudeSquared(arg0)
    ret = _invoke(1610743808, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dCrossProduct
  # method Point2dCrossProduct
  #   Point2d arg0 --- Vector1 [IN]
  #   Point2d arg1 --- Vector2 [IN]
  def Point2dCrossProduct(arg0, arg1)
    ret = _invoke(1610743809, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dCrossProduct3Points
  # method Point2dCrossProduct3Points
  #   Point2d arg0 --- Origin [IN]
  #   Point2d arg1 --- Target1 [IN]
  #   Point2d arg2 --- Target2 [IN]
  def Point2dCrossProduct3Points(arg0, arg1, arg2)
    ret = _invoke(1610743810, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dDotProduct
  # method Point2dDotProduct
  #   Point2d arg0 --- Vector1 [IN]
  #   Point2d arg1 --- Vector2 [IN]
  def Point2dDotProduct(arg0, arg1)
    ret = _invoke(1610743811, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dDotProduct3Points
  # method Point2dDotProduct3Points
  #   Point2d arg0 --- Origin [IN]
  #   Point2d arg1 --- Target1 [IN]
  #   Point2d arg2 --- Target2 [IN]
  def Point2dDotProduct3Points(arg0, arg1, arg2)
    ret = _invoke(1610743812, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dDistanceSquared
  # method Point2dDistanceSquared
  #   Point2d arg0 --- Point1 [IN]
  #   Point2d arg1 --- Point2 [IN]
  def Point2dDistanceSquared(arg0, arg1)
    ret = _invoke(1610743813, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dAddScaled
  # method Point2dAddScaled
  #   Point2d arg0 --- Origin [IN]
  #   Point2d arg1 --- Vector [IN]
  #   R8 arg2 --- Scale [IN]
  def Point2dAddScaled(arg0, arg1, arg2)
    ret = _invoke(1610743814, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dInterpolate
  # method Point2dInterpolate
  #   Point2d arg0 --- Point0 [IN]
  #   R8 arg1 --- S [IN]
  #   Point2d arg2 --- Point1 [IN]
  def Point2dInterpolate(arg0, arg1, arg2)
    ret = _invoke(1610743815, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dAdd
  # method Point2dAdd
  #   Point2d arg0 --- Point1 [IN]
  #   Point2d arg1 --- Point2 [IN]
  def Point2dAdd(arg0, arg1)
    ret = _invoke(1610743816, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dSubtract
  # method Point2dSubtract
  #   Point2d arg0 --- Point1 [IN]
  #   Point2d arg1 --- Point2 [IN]
  def Point2dSubtract(arg0, arg1)
    ret = _invoke(1610743817, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dNormalize
  # method Point2dNormalize
  #   Point2d arg0 --- Vector [IN]
  def Point2dNormalize(arg0)
    ret = _invoke(1610743818, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dDotDifference
  # method Point2dDotDifference
  #   Point2d arg0 --- TargetPoint [IN]
  #   Point2d arg1 --- Origin [IN]
  #   Point2d arg2 --- Vector [IN]
  def Point2dDotDifference(arg0, arg1, arg2)
    ret = _invoke(1610743819, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dZero
  # method Point2dZero
  def Point2dZero
    ret = _invoke(1610743820, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dOne
  # method Point2dOne
  def Point2dOne
    ret = _invoke(1610743821, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dFromXY
  # method Point2dFromXY
  #   R8 arg0 --- X [IN]
  #   R8 arg1 --- Y [IN]
  def Point2dFromXY(arg0, arg1)
    ret = _invoke(1610743822, [arg0, arg1], [VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dGetComponent
  # method Point2dGetComponent
  #   Point2d arg0 --- Point [IN]
  #   INT arg1 --- Index [IN]
  def Point2dGetComponent(arg0, arg1)
    ret = _invoke(1610743823, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dAdd2Scaled
  # method Point2dAdd2Scaled
  #   Point2d arg0 --- Origin [IN]
  #   Point2d arg1 --- Vector1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Point2d arg3 --- Vector2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  def Point2dAdd2Scaled(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610743824, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dAdd3Scaled
  # method Point2dAdd3Scaled
  #   Point2d arg0 --- Origin [IN]
  #   Point2d arg1 --- Vector1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Point2d arg3 --- Vector2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  #   Point2d arg5 --- Vector3 [IN]
  #   R8 arg6 --- Scale3 [IN]
  def Point2dAdd3Scaled(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    ret = _invoke(1610743825, [arg0, arg1, arg2, arg3, arg4, arg5, arg6], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dSignedAngleBetweenVectors
  # method Point2dSignedAngleBetweenVectors
  #   Point2d arg0 --- Vector1 [IN]
  #   Point2d arg1 --- Vector2 [IN]
  def Point2dSignedAngleBetweenVectors(arg0, arg1)
    ret = _invoke(1610743826, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dDistance
  # method Point2dDistance
  #   Point2d arg0 --- Point0 [IN]
  #   Point2d arg1 --- Point1 [IN]
  def Point2dDistance(arg0, arg1)
    ret = _invoke(1610743827, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dMagnitude
  # method Point2dMagnitude
  #   Point2d arg0 --- Vector [IN]
  def Point2dMagnitude(arg0)
    ret = _invoke(1610743828, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point2d Point2dNegate
  # method Point2dNegate
  #   Point2d arg0 --- Vector [IN]
  def Point2dNegate(arg0)
    ret = _invoke(1610743829, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point2dAreVectorsParallel
  # method Point2dAreVectorsParallel
  #   Point2d arg0 --- Vector1 [IN]
  #   Point2d arg1 --- Vector2 [IN]
  def Point2dAreVectorsParallel(arg0, arg1)
    ret = _invoke(1610743830, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point2dAreVectorsPerpendicular
  # method Point2dAreVectorsPerpendicular
  #   Point2d arg0 --- Vector1 [IN]
  #   Point2d arg1 --- Vector2 [IN]
  def Point2dAreVectorsPerpendicular(arg0, arg1)
    ret = _invoke(1610743831, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point2dEqual
  # method Point2dEqual
  #   Point2d arg0 --- Vector1 [IN]
  #   Point2d arg1 --- Vector2 [IN]
  def Point2dEqual(arg0, arg1)
    ret = _invoke(1610743832, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point2dEqualTolerance
  # method Point2dEqualTolerance
  #   Point2d arg0 --- Vector1 [IN]
  #   Point2d arg1 --- Vector2 [IN]
  #   R8 arg2 --- Tolerance [IN]
  def Point2dEqualTolerance(arg0, arg1, arg2)
    ret = _invoke(1610743833, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point2dMaxAbs
  # method Point2dMaxAbs
  #   Point2d arg0 --- Vector [IN]
  def Point2dMaxAbs(arg0)
    ret = _invoke(1610743834, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dCrossProduct
  # method Point3dCrossProduct
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dCrossProduct(arg0, arg1)
    ret = _invoke(1610743835, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dCrossProduct3Points
  # method Point3dCrossProduct3Points
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Target1 [IN]
  #   Point3d arg2 --- Target2 [IN]
  def Point3dCrossProduct3Points(arg0, arg1, arg2)
    ret = _invoke(1610743836, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dCrossProduct3PointsXY
  # method Point3dCrossProduct3PointsXY
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Target1 [IN]
  #   Point3d arg2 --- Target2 [IN]
  def Point3dCrossProduct3PointsXY(arg0, arg1, arg2)
    ret = _invoke(1610743837, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dCrossProductXY
  # method Point3dCrossProductXY
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dCrossProductXY(arg0, arg1)
    ret = _invoke(1610743838, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDotProduct3Points
  # method Point3dDotProduct3Points
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Target1 [IN]
  #   Point3d arg2 --- Target2 [IN]
  def Point3dDotProduct3Points(arg0, arg1, arg2)
    ret = _invoke(1610743839, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDotProduct3PointsXY
  # method Point3dDotProduct3PointsXY
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Target1 [IN]
  #   Point3d arg2 --- Target2 [IN]
  def Point3dDotProduct3PointsXY(arg0, arg1, arg2)
    ret = _invoke(1610743840, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDotProduct
  # method Point3dDotProduct
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dDotProduct(arg0, arg1)
    ret = _invoke(1610743841, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDotProductXY
  # method Point3dDotProductXY
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dDotProductXY(arg0, arg1)
    ret = _invoke(1610743842, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDotDifference
  # method Point3dDotDifference
  #   Point3d arg0 --- Target [IN]
  #   Point3d arg1 --- Origin [IN]
  #   Point3d arg2 --- Vector [IN]
  def Point3dDotDifference(arg0, arg1, arg2)
    ret = _invoke(1610743843, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dTripleProduct
  # method Point3dTripleProduct
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  #   Point3d arg2 --- Vector3 [IN]
  def Point3dTripleProduct(arg0, arg1, arg2)
    ret = _invoke(1610743844, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dTripleProduct4Points
  # method Point3dTripleProduct4Points
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Target1 [IN]
  #   Point3d arg2 --- Target2 [IN]
  #   Point3d arg3 --- Target3 [IN]
  def Point3dTripleProduct4Points(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743845, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dZero
  # method Point3dZero
  def Point3dZero
    ret = _invoke(1610743846, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dOne
  # method Point3dOne
  def Point3dOne
    ret = _invoke(1610743847, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromXYZ
  # method Point3dFromXYZ
  #   R8 arg0 --- Ax [IN]
  #   R8 arg1 --- Ay [IN]
  #   R8 arg2 --- Az [IN]
  def Point3dFromXYZ(arg0, arg1, arg2)
    ret = _invoke(1610743848, [arg0, arg1, arg2], [VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromXY
  # method Point3dFromXY
  #   R8 arg0 --- Ax [IN]
  #   R8 arg1 --- Ay [IN]
  def Point3dFromXY(arg0, arg1)
    ret = _invoke(1610743849, [arg0, arg1], [VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dGetComponent
  # method Point3dGetComponent
  #   Point3d arg0 --- Point [IN]
  #   INT arg1 --- Index [IN]
  def Point3dGetComponent(arg0, arg1)
    ret = _invoke(1610743850, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAdd
  # method Point3dAdd
  #   Point3d arg0 --- Point1 [IN]
  #   Point3d arg1 --- Point2 [IN]
  def Point3dAdd(arg0, arg1)
    ret = _invoke(1610743851, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAddScaled
  # method Point3dAddScaled
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Vector [IN]
  #   R8 arg2 --- Scale [IN]
  def Point3dAddScaled(arg0, arg1, arg2)
    ret = _invoke(1610743852, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dInterpolate
  # method Point3dInterpolate
  #   Point3d arg0 --- Point0 [IN]
  #   R8 arg1 --- FractionParameter [IN]
  #   Point3d arg2 --- Point1 [IN]
  def Point3dInterpolate(arg0, arg1, arg2)
    ret = _invoke(1610743853, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAdd2Scaled
  # method Point3dAdd2Scaled
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Vector1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Point3d arg3 --- Vector2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  def Point3dAdd2Scaled(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610743854, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAdd3Scaled
  # method Point3dAdd3Scaled
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Vector1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Point3d arg3 --- Vector2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  #   Point3d arg5 --- Vector3 [IN]
  #   R8 arg6 --- Scale3 [IN]
  def Point3dAdd3Scaled(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    ret = _invoke(1610743855, [arg0, arg1, arg2, arg3, arg4, arg5, arg6], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dAngleBetweenVectors
  # method Point3dAngleBetweenVectors
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dAngleBetweenVectors(arg0, arg1)
    ret = _invoke(1610743856, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dSmallerAngleBetweenUnorientedVectors
  # method Point3dSmallerAngleBetweenUnorientedVectors
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dSmallerAngleBetweenUnorientedVectors(arg0, arg1)
    ret = _invoke(1610743857, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point3dIsVectorInSmallerSector
  # method Point3dIsVectorInSmallerSector
  #   Point3d arg0 --- TestVector [IN]
  #   Point3d arg1 --- Vector0 [IN]
  #   Point3d arg2 --- Vector1 [IN]
  def Point3dIsVectorInSmallerSector(arg0, arg1, arg2)
    ret = _invoke(1610743858, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point3dIsPointInSmallerSector
  # method Point3dIsPointInSmallerSector
  #   Point3d arg0 --- TestPoint [IN]
  #   Point3d arg1 --- Origin [IN]
  #   Point3d arg2 --- Target1 [IN]
  #   Point3d arg3 --- Target2 [IN]
  def Point3dIsPointInSmallerSector(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743859, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point3dIsVectorInCCWSector
  # method Point3dIsVectorInCCWSector
  #   Point3d arg0 --- TestVector [IN]
  #   Point3d arg1 --- Vector0 [IN]
  #   Point3d arg2 --- Vector1 [IN]
  #   Point3d arg3 --- UpVector [IN]
  def Point3dIsVectorInCCWSector(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743860, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point3dIsPointInCCWSector
  # method Point3dIsPointInCCWSector
  #   Point3d arg0 --- TestPoint [IN]
  #   Point3d arg1 --- Origin [IN]
  #   Point3d arg2 --- Target0 [IN]
  #   Point3d arg3 --- Target1 [IN]
  #   Point3d arg4 --- UpVector [IN]
  def Point3dIsPointInCCWSector(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610743861, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dAngleBetweenVectorsXY
  # method Point3dAngleBetweenVectorsXY
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dAngleBetweenVectorsXY(arg0, arg1)
    ret = _invoke(1610743862, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dSmallerAngleBetweenUnorientedVectorsXY
  # method Point3dSmallerAngleBetweenUnorientedVectorsXY
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dSmallerAngleBetweenUnorientedVectorsXY(arg0, arg1)
    ret = _invoke(1610743863, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dRotateXY
  # method Point3dRotateXY
  #   Point3d arg0 --- Vector [IN]
  #   R8 arg1 --- Theta [IN]
  def Point3dRotateXY(arg0, arg1)
    ret = _invoke(1610743864, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dSignedAngleBetweenVectors
  # method Point3dSignedAngleBetweenVectors
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  #   Point3d arg2 --- OrientationVector [IN]
  def Point3dSignedAngleBetweenVectors(arg0, arg1, arg2)
    ret = _invoke(1610743865, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dPlanarAngleBetweenVectors
  # method Point3dPlanarAngleBetweenVectors
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  #   Point3d arg2 --- PlaneNormal [IN]
  def Point3dPlanarAngleBetweenVectors(arg0, arg1, arg2)
    ret = _invoke(1610743866, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dSubtract
  # method Point3dSubtract
  #   Point3d arg0 --- Point1 [IN]
  #   Point3d arg1 --- Point2 [IN]
  def Point3dSubtract(arg0, arg1)
    ret = _invoke(1610743867, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDistance
  # method Point3dDistance
  #   Point3d arg0 --- Point1 [IN]
  #   Point3d arg1 --- Point2 [IN]
  def Point3dDistance(arg0, arg1)
    ret = _invoke(1610743868, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dMagnitudeSquared
  # method Point3dMagnitudeSquared
  #   Point3d arg0 --- Vector [IN]
  def Point3dMagnitudeSquared(arg0)
    ret = _invoke(1610743869, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDistanceSquared
  # method Point3dDistanceSquared
  #   Point3d arg0 --- Point1 [IN]
  #   Point3d arg1 --- Point2 [IN]
  def Point3dDistanceSquared(arg0, arg1)
    ret = _invoke(1610743870, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDistanceSquaredXY
  # method Point3dDistanceSquaredXY
  #   Point3d arg0 --- Point1 [IN]
  #   Point3d arg1 --- Point2 [IN]
  def Point3dDistanceSquaredXY(arg0, arg1)
    ret = _invoke(1610743871, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDistanceXY
  # method Point3dDistanceXY
  #   Point3d arg0 --- Point1 [IN]
  #   Point3d arg1 --- Point2 [IN]
  def Point3dDistanceXY(arg0, arg1)
    ret = _invoke(1610743872, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dMagnitude
  # method Point3dMagnitude
  #   Point3d arg0 --- Vector [IN]
  def Point3dMagnitude(arg0)
    ret = _invoke(1610743873, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dMaxAbs
  # method Point3dMaxAbs
  #   Point3d arg0 --- Vector [IN]
  def Point3dMaxAbs(arg0)
    ret = _invoke(1610743874, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point3dEqual
  # method Point3dEqual
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dEqual(arg0, arg1)
    ret = _invoke(1610743875, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point3dEqualTolerance
  # method Point3dEqualTolerance
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  #   R8 arg2 --- Tolerance [IN]
  def Point3dEqualTolerance(arg0, arg1, arg2)
    ret = _invoke(1610743876, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dScale
  # method Point3dScale
  #   Point3d arg0 --- Vector [IN]
  #   R8 arg1 --- Scale [IN]
  def Point3dScale(arg0, arg1)
    ret = _invoke(1610743877, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dNegate
  # method Point3dNegate
  #   Point3d arg0 --- Vector [IN]
  def Point3dNegate(arg0)
    ret = _invoke(1610743878, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dNormalize
  # method Point3dNormalize
  #   Point3d arg0 --- Vector [IN]
  def Point3dNormalize(arg0)
    ret = _invoke(1610743879, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point3dAreVectorsParallel
  # method Point3dAreVectorsParallel
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dAreVectorsParallel(arg0, arg1)
    ret = _invoke(1610743880, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Point3dAreVectorsPerpendicular
  # method Point3dAreVectorsPerpendicular
  #   Point3d arg0 --- Vector1 [IN]
  #   Point3d arg1 --- Vector2 [IN]
  def Point3dAreVectorsPerpendicular(arg0, arg1)
    ret = _invoke(1610743881, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Point3dSetComponent
  # method Point3dSetComponent
  #   Point3d arg0 --- Point [IN/OUT]
  #   INT arg1 --- Index [IN]
  #   R8 arg2 --- Value [IN]
  def Point3dSetComponent(arg0, arg1, arg2)
    ret = _invoke(1610743882, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_I4, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromMatrix3dTimesPoint3d
  # method Point3dFromMatrix3dTimesPoint3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Point3d arg1 --- Point [IN]
  def Point3dFromMatrix3dTimesPoint3d(arg0, arg1)
    ret = _invoke(1610743883, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromMatrix3dTransposeTimesPoint3d
  # method Point3dFromMatrix3dTransposeTimesPoint3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Point3d arg1 --- Point [IN]
  def Point3dFromMatrix3dTransposeTimesPoint3d(arg0, arg1)
    ret = _invoke(1610743884, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromMatrix3dTimesXYZ
  # method Point3dFromMatrix3dTimesXYZ
  #   Matrix3d arg0 --- Matrix [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Point3dFromMatrix3dTimesXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743885, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromMatrix3dTransposeTimesXYZ
  # method Point3dFromMatrix3dTransposeTimesXYZ
  #   Matrix3d arg0 --- Matrix [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Point3dFromMatrix3dTransposeTimesXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743886, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromMatrix3dTimesMatrix3d
  # method Matrix3dFromMatrix3dTimesMatrix3d
  #   Matrix3d arg0 --- A [IN]
  #   Matrix3d arg1 --- B [IN]
  def Matrix3dFromMatrix3dTimesMatrix3d(arg0, arg1)
    ret = _invoke(1610743887, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromMatrix3dTimesMatrix3dTimesMatrix3d
  # method Matrix3dFromMatrix3dTimesMatrix3dTimesMatrix3d
  #   Matrix3d arg0 --- A [IN]
  #   Matrix3d arg1 --- B [IN]
  #   Matrix3d arg2 --- C [IN]
  def Matrix3dFromMatrix3dTimesMatrix3dTimesMatrix3d(arg0, arg1, arg2)
    ret = _invoke(1610743888, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dIdentity
  # method Matrix3dIdentity
  def Matrix3dIdentity
    ret = _invoke(1610743889, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dZero
  # method Matrix3dZero
  def Matrix3dZero
    ret = _invoke(1610743890, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromScaleFactors
  # method Matrix3dFromScaleFactors
  #   R8 arg0 --- Xscale [IN]
  #   R8 arg1 --- Yscale [IN]
  #   R8 arg2 --- Zscale [IN]
  def Matrix3dFromScaleFactors(arg0, arg1, arg2)
    ret = _invoke(1610743891, [arg0, arg1, arg2], [VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromScale
  # method Matrix3dFromScale
  #   R8 arg0 --- Scale [IN]
  def Matrix3dFromScale(arg0)
    ret = _invoke(1610743892, [arg0], [VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromRowValues
  # method Matrix3dFromRowValues
  #   R8 arg0 --- X00 [IN]
  #   R8 arg1 --- X01 [IN]
  #   R8 arg2 --- X02 [IN]
  #   R8 arg3 --- X10 [IN]
  #   R8 arg4 --- X11 [IN]
  #   R8 arg5 --- X12 [IN]
  #   R8 arg6 --- X20 [IN]
  #   R8 arg7 --- X21 [IN]
  #   R8 arg8 --- X22 [IN]
  def Matrix3dFromRowValues(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    ret = _invoke(1610743893, [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8], [VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromPoint3dColumns
  # method Matrix3dFromPoint3dColumns
  #   Point3d arg0 --- XVector [IN]
  #   Point3d arg1 --- YVector [IN]
  #   Point3d arg2 --- ZVector [IN]
  def Matrix3dFromPoint3dColumns(arg0, arg1, arg2)
    ret = _invoke(1610743894, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromPoint3dRows
  # method Matrix3dFromPoint3dRows
  #   Point3d arg0 --- XVector [IN]
  #   Point3d arg1 --- YVector [IN]
  #   Point3d arg2 --- ZVector [IN]
  def Matrix3dFromPoint3dRows(arg0, arg1, arg2)
    ret = _invoke(1610743895, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromVectorAndRotationAngle
  # method Matrix3dFromVectorAndRotationAngle
  #   Point3d arg0 --- Axis [IN]
  #   R8 arg1 --- Radians [IN]
  def Matrix3dFromVectorAndRotationAngle(arg0, arg1)
    ret = _invoke(1610743896, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromDirectionAndScale
  # method Matrix3dFromDirectionAndScale
  #   Point3d arg0 --- Vector [IN]
  #   R8 arg1 --- Scale [IN]
  def Matrix3dFromDirectionAndScale(arg0, arg1)
    ret = _invoke(1610743897, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromAxisAndRotationAngle
  # method Matrix3dFromAxisAndRotationAngle
  #   INT arg0 --- Axis [IN]
  #   R8 arg1 --- Radians [IN]
  def Matrix3dFromAxisAndRotationAngle(arg0, arg1)
    ret = _invoke(1610743898, [arg0, arg1], [VT_I4, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dTranspose
  # method Matrix3dTranspose
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dTranspose(arg0)
    ret = _invoke(1610743899, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dInverse
  # method Matrix3dInverse
  #   Matrix3d arg0 --- Forward [IN]
  def Matrix3dInverse(arg0)
    ret = _invoke(1610743900, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dHasInverse
  # method Matrix3dHasInverse
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dHasInverse(arg0)
    ret = _invoke(1610743901, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromMatrix3dInverseTimesPoint3d
  # method Point3dFromMatrix3dInverseTimesPoint3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Point3d arg1 --- Point [IN]
  def Point3dFromMatrix3dInverseTimesPoint3d(arg0, arg1)
    ret = _invoke(1610743902, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromMatrix3dInverseTransposeTimesPoint3d
  # method Point3dFromMatrix3dInverseTransposeTimesPoint3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Point3d arg1 --- Point [IN]
  def Point3dFromMatrix3dInverseTransposeTimesPoint3d(arg0, arg1)
    ret = _invoke(1610743903, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromMatrix3dColumn
  # method Point3dFromMatrix3dColumn
  #   Matrix3d arg0 --- Matrix [IN]
  #   INT arg1 --- Col [IN]
  def Point3dFromMatrix3dColumn(arg0, arg1)
    ret = _invoke(1610743904, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Matrix3dGetComponentByRowAndColumn
  # method Matrix3dGetComponentByRowAndColumn
  #   Matrix3d arg0 --- Matrix [IN]
  #   INT arg1 --- Row [IN]
  #   INT arg2 --- Col [IN]
  def Matrix3dGetComponentByRowAndColumn(arg0, arg1, arg2)
    ret = _invoke(1610743905, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_I4, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromMatrix3dRow
  # method Point3dFromMatrix3dRow
  #   Matrix3d arg0 --- Matrix [IN]
  #   INT arg1 --- Row [IN]
  def Point3dFromMatrix3dRow(arg0, arg1)
    ret = _invoke(1610743906, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Matrix3dDeterminant
  # method Matrix3dDeterminant
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dDeterminant(arg0)
    ret = _invoke(1610743907, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dIsIdentity
  # method Matrix3dIsIdentity
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dIsIdentity(arg0)
    ret = _invoke(1610743908, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dIsSignedPermutation
  # method Matrix3dIsSignedPermutation
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dIsSignedPermutation(arg0)
    ret = _invoke(1610743909, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dIsRigid
  # method Matrix3dIsRigid
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dIsRigid(arg0)
    ret = _invoke(1610743910, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dIsOrthogonal
  # method Matrix3dIsOrthogonal
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dIsOrthogonal(arg0)
    ret = _invoke(1610743911, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dRotationFromPoint3dOriginXY
  # method Matrix3dRotationFromPoint3dOriginXY
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- XPoint [IN]
  #   Point3d arg2 --- YPoint [IN]
  def Matrix3dRotationFromPoint3dOriginXY(arg0, arg1, arg2)
    ret = _invoke(1610743912, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dAdd2Scaled
  # method Matrix3dAdd2Scaled
  #   Matrix3d arg0 --- Matrix0 [IN]
  #   Matrix3d arg1 --- Matrix1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Matrix3d arg3 --- Matrix2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  def Matrix3dAdd2Scaled(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610743913, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Matrix3dSumSquares
  # method Matrix3dSumSquares
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dSumSquares(arg0)
    ret = _invoke(1610743914, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Matrix3dMaxAbs
  # method Matrix3dMaxAbs
  #   Matrix3d arg0 --- Matrix [IN]
  def Matrix3dMaxAbs(arg0)
    ret = _invoke(1610743915, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Matrix3dMaxDiff
  # method Matrix3dMaxDiff
  #   Matrix3d arg0 --- Matrix1 [IN]
  #   Matrix3d arg1 --- Matrix2 [IN]
  def Matrix3dMaxDiff(arg0, arg1)
    ret = _invoke(1610743916, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dEqual
  # method Matrix3dEqual
  #   Matrix3d arg0 --- Matrix1 [IN]
  #   Matrix3d arg1 --- Matrix2 [IN]
  def Matrix3dEqual(arg0, arg1)
    ret = _invoke(1610743917, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dEqualTolerance
  # method Matrix3dEqualTolerance
  #   Matrix3d arg0 --- Matrix1 [IN]
  #   Matrix3d arg1 --- Matrix2 [IN]
  #   R8 arg2 --- Tolerance [IN]
  def Matrix3dEqualTolerance(arg0, arg1, arg2)
    ret = _invoke(1610743918, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Matrix3dSetComponentByRowAndColumn
  # method Matrix3dSetComponentByRowAndColumn
  #   Matrix3d arg0 --- Matrix [IN/OUT]
  #   INT arg1 --- RowIndex [IN]
  #   INT arg2 --- ColumnIndex [IN]
  #   R8 arg3 --- Value [IN]
  def Matrix3dSetComponentByRowAndColumn(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743919, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_I4, VT_I4, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Transform3dGetMatrixComponentByRowAndColumn
  # method Transform3dGetMatrixComponentByRowAndColumn
  #   Transform3d arg0 --- Transform [IN]
  #   INT arg1 --- Row [IN]
  #   INT arg2 --- Col [IN]
  def Transform3dGetMatrixComponentByRowAndColumn(arg0, arg1, arg2)
    ret = _invoke(1610743920, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_I4, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Transform3dGetPointComponent
  # method Transform3dGetPointComponent
  #   Transform3d arg0 --- Transform [IN]
  #   INT arg1 --- Row [IN]
  def Transform3dGetPointComponent(arg0, arg1)
    ret = _invoke(1610743921, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromTransform3dTimesPoint3d
  # method Point3dFromTransform3dTimesPoint3d
  #   Transform3d arg0 --- Transform [IN]
  #   Point3d arg1 --- Point [IN]
  def Point3dFromTransform3dTimesPoint3d(arg0, arg1)
    ret = _invoke(1610743922, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromTransform3dTimesXYZ
  # method Point3dFromTransform3dTimesXYZ
  #   Transform3d arg0 --- Transform [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Point3dFromTransform3dTimesXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743923, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromTransform3dTimesTransform3d
  # method Transform3dFromTransform3dTimesTransform3d
  #   Transform3d arg0 --- Transform1 [IN]
  #   Transform3d arg1 --- Transform2 [IN]
  def Transform3dFromTransform3dTimesTransform3d(arg0, arg1)
    ret = _invoke(1610743924, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromMatrix3dTimesTransform3d
  # method Transform3dFromMatrix3dTimesTransform3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Transform3d arg1 --- Transform [IN]
  def Transform3dFromMatrix3dTimesTransform3d(arg0, arg1)
    ret = _invoke(1610743925, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromTransform3dTimesMatrix3d
  # method Transform3dFromTransform3dTimesMatrix3d
  #   Transform3d arg0 --- Transform [IN]
  #   Matrix3d arg1 --- Matrix [IN]
  def Transform3dFromTransform3dTimesMatrix3d(arg0, arg1)
    ret = _invoke(1610743926, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dIdentity
  # method Transform3dIdentity
  def Transform3dIdentity
    ret = _invoke(1610743927, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromMatrix3d
  # method Transform3dFromMatrix3d
  #   Matrix3d arg0 --- Matrix [IN]
  def Transform3dFromMatrix3d(arg0)
    ret = _invoke(1610743928, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromMatrix3dPoint3d
  # method Transform3dFromMatrix3dPoint3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Point3d arg1 --- Translation [IN]
  def Transform3dFromMatrix3dPoint3d(arg0, arg1)
    ret = _invoke(1610743929, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromPoint3d
  # method Transform3dFromPoint3d
  #   Point3d arg0 --- Translation [IN]
  def Transform3dFromPoint3d(arg0)
    ret = _invoke(1610743930, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromXYZ
  # method Transform3dFromXYZ
  #   R8 arg0 --- X [IN]
  #   R8 arg1 --- Y [IN]
  #   R8 arg2 --- Z [IN]
  def Transform3dFromXYZ(arg0, arg1, arg2)
    ret = _invoke(1610743931, [arg0, arg1, arg2], [VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromRowValues
  # method Transform3dFromRowValues
  #   R8 arg0 --- X00 [IN]
  #   R8 arg1 --- X01 [IN]
  #   R8 arg2 --- X02 [IN]
  #   R8 arg3 --- Tx [IN]
  #   R8 arg4 --- X10 [IN]
  #   R8 arg5 --- X11 [IN]
  #   R8 arg6 --- X12 [IN]
  #   R8 arg7 --- Ty [IN]
  #   R8 arg8 --- X20 [IN]
  #   R8 arg9 --- X21 [IN]
  #   R8 arg10 --- X22 [IN]
  #   R8 arg11 --- Tz [IN]
  def Transform3dFromRowValues(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11)
    ret = _invoke(1610743932, [arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11], [VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromLineAndRotationAngle
  # method Transform3dFromLineAndRotationAngle
  #   Point3d arg0 --- Point0 [IN]
  #   Point3d arg1 --- Point1 [IN]
  #   R8 arg2 --- Radians [IN]
  def Transform3dFromLineAndRotationAngle(arg0, arg1, arg2)
    ret = _invoke(1610743933, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromMatrix3dAndFixedPoint3d
  # method Transform3dFromMatrix3dAndFixedPoint3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Point3d arg1 --- Origin [IN]
  def Transform3dFromMatrix3dAndFixedPoint3d(arg0, arg1)
    ret = _invoke(1610743934, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dInverse
  # method Transform3dInverse
  #   Transform3d arg0 --- In [IN]
  def Transform3dInverse(arg0)
    ret = _invoke(1610743935, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dHasInverse
  # method Transform3dHasInverse
  #   Transform3d arg0 --- Transform [IN]
  def Transform3dHasInverse(arg0)
    ret = _invoke(1610743936, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromTransform3d
  # method Point3dFromTransform3d
  #   Transform3d arg0 --- Transform [IN]
  def Point3dFromTransform3d(arg0)
    ret = _invoke(1610743937, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromTransform3d
  # method Matrix3dFromTransform3d
  #   Transform3d arg0 --- Transform [IN]
  def Matrix3dFromTransform3d(arg0)
    ret = _invoke(1610743938, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsIdentity
  # method Transform3dIsIdentity
  #   Transform3d arg0 --- Transform [IN]
  def Transform3dIsIdentity(arg0)
    ret = _invoke(1610743939, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsRigid
  # method Transform3dIsRigid
  #   Transform3d arg0 --- Transform [IN]
  def Transform3dIsRigid(arg0)
    ret = _invoke(1610743940, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsPlanar
  # method Transform3dIsPlanar
  #   Transform3d arg0 --- Transform [IN]
  #   Point3d arg1 --- Normal [IN]
  def Transform3dIsPlanar(arg0, arg1)
    ret = _invoke(1610743941, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dEqual
  # method Transform3dEqual
  #   Transform3d arg0 --- Transform1 [IN]
  #   Transform3d arg1 --- Transform2 [IN]
  def Transform3dEqual(arg0, arg1)
    ret = _invoke(1610743942, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dEqualTolerance
  # method Transform3dEqualTolerance
  #   Transform3d arg0 --- Transform1 [IN]
  #   Transform3d arg1 --- Transform2 [IN]
  #   R8 arg2 --- MatrixTolerance [IN]
  #   R8 arg3 --- PointTolerance [IN]
  def Transform3dEqualTolerance(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743943, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromSquaredTransform3d
  # method Transform3dFromSquaredTransform3d
  #   Transform3d arg0 --- Transform [IN]
  #   INT arg1 --- PrimaryAxis [IN]
  #   INT arg2 --- SecondaryAxis [IN]
  def Transform3dFromSquaredTransform3d(arg0, arg1, arg2)
    ret = _invoke(1610743944, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_I4, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Transform3dSetMatrixComponentByRowAndColumn
  # method Transform3dSetComponentByRowAndColumn
  #   Transform3d arg0 --- Transform [IN/OUT]
  #   INT arg1 --- RowIndex [IN]
  #   INT arg2 --- ColumnIndex [IN]
  #   R8 arg3 --- Value [IN]
  def Transform3dSetMatrixComponentByRowAndColumn(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743945, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_I4, VT_I4, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Transform3dSetPointComponent
  # method Transform3dSetPointComponent
  #   Transform3d arg0 --- Transform [IN/OUT]
  #   INT arg1 --- RowIndex [IN]
  #   R8 arg2 --- Value [IN]
  def Transform3dSetPointComponent(arg0, arg1, arg2)
    ret = _invoke(1610743946, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_I4, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RedrawAllViews
  #   MsdDrawingMode arg0 --- DrawMode [IN] ( = 0)
  def RedrawAllViews(arg0 = nil)
    ret = _invoke(1610743947, [arg0], [VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID ShowCommand
  #   BSTR arg0 --- Command [IN]
  def ShowCommand(arg0 = nil)
    ret = _invoke(1610743952, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID ShowPrompt
  #   BSTR arg0 --- Prompt [IN]
  def ShowPrompt(arg0 = nil)
    ret = _invoke(1610743953, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID ShowStatus
  #   BSTR arg0 --- Status [IN]
  def ShowStatus(arg0 = nil)
    ret = _invoke(1610743954, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID ShowError
  #   BSTR arg0 --- Error [IN]
  def ShowError(arg0 = nil)
    ret = _invoke(1610743955, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID ShowTempMessage
  #   MsdStatusBarArea arg0 --- Area [IN]
  #   BSTR arg1 --- Message [IN]
  #   BSTR arg2 --- Details [IN]
  def ShowTempMessage(arg0, arg1, arg2 = nil)
    ret = _invoke(1610743956, [arg0, arg1, arg2], [VT_DISPATCH, VT_BSTR, VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _DesignFile CreateDesignFile
  #   BSTR arg0 --- SeedFileName [IN]
  #   BSTR arg1 --- NewDesignFileName [IN]
  #   BOOL arg2 --- Open [IN]
  def CreateDesignFile(arg0, arg1, arg2)
    ret = _invoke(1610743963, [arg0, arg1, arg2], [VT_BSTR, VT_BSTR, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID CopyDesignFile
  #   BSTR arg0 --- ExistingDesignFileName [IN]
  #   BSTR arg1 --- NewDesignFileName [IN]
  #   BOOL arg2 --- Overwrite [IN]
  def CopyDesignFile(arg0, arg1, arg2 = nil)
    ret = _invoke(1610743964, [arg0, arg1, arg2], [VT_BSTR, VT_BSTR, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _DesignFile OpenDesignFile
  #   BSTR arg0 --- DesignFileName [IN]
  #   BOOL arg1 --- ReadOnly [IN]
  #   MsdV7Action arg2 --- V7Action [IN] ( = 0)
  def OpenDesignFile(arg0, arg1 = nil, arg2 = nil)
    ret = _invoke(1610743965, [arg0, arg1, arg2], [VT_BSTR, VT_BOOL, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RegisterV8ToV7Filter
  #   IConvertV8ToV7 arg0 --- Handler [IN]
  def RegisterV8ToV7Filter(arg0)
    ret = _invoke(1610743968, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID SetCExpressionValue
  #   BSTR arg0 --- CExpression [IN]
  #   VARIANT arg1 --- NewValue [IN]
  #   BSTR arg2 --- MdlApplicationName [IN]
  def SetCExpressionValue(arg0, arg1, arg2 = nil)
    ret = _invoke(1610743969, [arg0, arg1, arg2], [VT_BSTR, VT_VARIANT, VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VARIANT GetCExpressionValue
  #   BSTR arg0 --- CExpression [IN]
  #   BSTR arg1 --- MdlApplicationName [IN]
  def GetCExpressionValue(arg0, arg1 = nil)
    ret = _invoke(1610743970, [arg0, arg1], [VT_BSTR, VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID SetCExpressionValueAsDLong
  #   BSTR arg0 --- CExpression [IN]
  #   DLong arg1 --- NewValue [IN]
  #   BSTR arg2 --- MdlApplicationName [IN]
  def SetCExpressionValueAsDLong(arg0, arg1, arg2 = nil)
    ret = _invoke(1610743971, [arg0, arg1, arg2], [VT_BSTR, VT_BYREF | VT_DISPATCH, VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong GetCExpressionValueAsDLong
  #   BSTR arg0 --- CExpression [IN]
  #   BSTR arg1 --- MdlApplicationName [IN]
  def GetCExpressionValueAsDLong(arg0, arg1 = nil)
    ret = _invoke(1610743972, [arg0, arg1], [VT_BSTR, VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Pi
  def Pi
    ret = _invoke(1610743973, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Degrees
  #   R8 arg0 --- Radians [IN]
  def Degrees(arg0)
    ret = _invoke(1610743974, [arg0], [VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Radians
  #   R8 arg0 --- Degrees [IN]
  def Radians(arg0)
    ret = _invoke(1610743975, [arg0], [VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ArcElement CreateArcElement1
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- StartPoint [IN/OUT]
  #   Point3d arg2 --- CenterPoint [IN/OUT]
  #   Point3d arg3 --- EndPoint [IN/OUT]
  def CreateArcElement1(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743976, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ArcElement CreateArcElement2
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- CenterPoint [IN/OUT]
  #   R8 arg2 --- PrimaryRadius [IN]
  #   R8 arg3 --- SecondaryRadius [IN]
  #   Matrix3d arg4 --- Rotation [IN/OUT]
  #   R8 arg5 --- StartAngle [IN]
  #   R8 arg6 --- SweepAngle [IN]
  def CreateArcElement2(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    ret = _invoke(1610743977, [arg0, arg1, arg2, arg3, arg4, arg5, arg6], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CurveElement CreateCurveElement1
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- Points [IN/OUT]
  def CreateCurveElement1(arg0, arg1)
    ret = _invoke(1610743978, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_ARRAY | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _EllipseElement CreateEllipseElement1
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- PerimeterPoint1 [IN/OUT]
  #   Point3d arg2 --- PerimeterPoint2 [IN/OUT]
  #   Point3d arg3 --- PerimeterPoint3 [IN/OUT]
  #   MsdFillMode arg4 --- FillMode [IN] ( = -1)
  def CreateEllipseElement1(arg0, arg1, arg2, arg3, arg4 = nil)
    ret = _invoke(1610743979, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _EllipseElement CreateEllipseElement2
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- Origin [IN/OUT]
  #   R8 arg2 --- PrimaryRadius [IN]
  #   R8 arg3 --- SecondaryRadius [IN]
  #   Matrix3d arg4 --- Rotation [IN/OUT]
  #   MsdFillMode arg5 --- FillMode [IN] ( = -1)
  def CreateEllipseElement2(arg0, arg1, arg2, arg3, arg4, arg5 = nil)
    ret = _invoke(1610743980, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_BYREF | VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _LineElement CreateLineElement1
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- Vertices [IN/OUT]
  def CreateLineElement1(arg0, arg1)
    ret = _invoke(1610743981, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_ARRAY | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _LineElement CreateLineElement2
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- StartPoint [IN/OUT]
  #   Point3d arg2 --- EndPoint [IN/OUT]
  def CreateLineElement2(arg0, arg1, arg2)
    ret = _invoke(1610743982, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ShapeElement CreateShapeElement1
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- Vertices [IN/OUT]
  #   MsdFillMode arg2 --- FillMode [IN] ( = -1)
  def CreateShapeElement1(arg0, arg1, arg2 = nil)
    ret = _invoke(1610743983, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_ARRAY | VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ConeElement CreateConeElement1
  #   _Element arg0 --- Template [IN]
  #   R8 arg1 --- BaseRadius [IN]
  #   Point3d arg2 --- BaseCenterPoint [IN/OUT]
  #   R8 arg3 --- TopRadius [IN]
  #   Point3d arg4 --- TopCenterPoint [IN/OUT]
  #   Matrix3d arg5 --- Rotation [IN/OUT]
  def CreateConeElement1(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610743984, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ConeElement CreateConeElement2
  #   _Element arg0 --- Template [IN]
  #   R8 arg1 --- Radius [IN]
  #   Point3d arg2 --- BaseCenterPoint [IN/OUT]
  #   Point3d arg3 --- TopCenterPoint [IN/OUT]
  def CreateConeElement2(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743985, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ComplexShapeElement CreateComplexShapeElement1
  #   ChainableElement arg0 --- ChainableElements [IN/OUT]
  #   MsdFillMode arg1 --- FillMode [IN] ( = -1)
  def CreateComplexShapeElement1(arg0, arg1 = nil)
    ret = _invoke(1610743986, [arg0, arg1], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ComplexStringElement CreateComplexStringElement1
  #   ChainableElement arg0 --- ChainableElements [IN/OUT]
  def CreateComplexStringElement1(arg0)
    ret = _invoke(1610743987, [arg0], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _DimensionElement CreateDimensionElement1
  #   _Element arg0 --- Template [IN]
  #   Matrix3d arg1 --- Rotation [IN]
  #   MsdDimType arg2 --- Type [IN]
  #   _View arg3 --- TextOrientationView [IN]
  def CreateDimensionElement1(arg0, arg1, arg2, arg3 = nil)
    ret = _invoke(1610743988, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _TextElement CreateTextElement1
  #   _Element arg0 --- Template [IN]
  #   BSTR arg1 --- Text [IN]
  #   Point3d arg2 --- Origin [IN/OUT]
  #   Matrix3d arg3 --- Rotation [IN/OUT]
  def CreateTextElement1(arg0, arg1, arg2, arg3)
    ret = _invoke(1610743990, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BSTR, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _TextNodeElement CreateTextNodeElement1
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- Origin [IN/OUT]
  #   Matrix3d arg2 --- Rotation [IN/OUT]
  def CreateTextNodeElement1(arg0, arg1, arg2)
    ret = _invoke(1610743991, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CellElement CreateCellElement1
  #   BSTR arg0 --- Name [IN]
  #   _Element arg1 --- Elements [IN/OUT]
  #   Point3d arg2 --- Origin [IN]
  #   BOOL arg3 --- IsPointCell [IN]
  def CreateCellElement1(arg0, arg1, arg2, arg3 = nil)
    ret = _invoke(1610743992, [arg0, arg1, arg2, arg3], [VT_BSTR, VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CellElement CreateCellElement2
  #   BSTR arg0 --- CellName [IN]
  #   Point3d arg1 --- Origin [IN/OUT]
  #   Point3d arg2 --- Scale [IN/OUT]
  #   BOOL arg3 --- TrueScale [IN]
  #   Matrix3d arg4 --- Rotation [IN/OUT]
  def CreateCellElement2(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610743993, [arg0, arg1, arg2, arg3, arg4], [VT_BSTR, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BOOL, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CellElement CreateCellElement3
  #   BSTR arg0 --- CellName [IN]
  #   Point3d arg1 --- Origin [IN/OUT]
  #   BOOL arg2 --- TrueScale [IN]
  def CreateCellElement3(arg0, arg1, arg2)
    ret = _invoke(1610743994, [arg0, arg1, arg2], [VT_BSTR, VT_BYREF | VT_DISPATCH, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AttachCellLibrary
  #   BSTR arg0 --- CellLibraryName [IN]
  #   MsdConversionMode arg1 --- ConvertFromV7 [IN] ( = 1)
  def AttachCellLibrary(arg0, arg1 = nil)
    ret = _invoke(1610743995, [arg0, arg1], [VT_BSTR, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID DetachCellLibrary
  def DetachCellLibrary
    ret = _invoke(1610743996, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CellInformationEnumerator GetCellInformationEnumerator
  #   BOOL arg0 --- IncludeSharedCells [IN]
  #   BOOL arg1 --- IncludeFullPath [IN]
  def GetCellInformationEnumerator(arg0, arg1)
    ret = _invoke(1610744001, [arg0, arg1], [VT_BOOL, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _SharedCellElement CreateSharedCellElement1
  #   BSTR arg0 --- Name [IN]
  #   _Element arg1 --- Elements [IN/OUT]
  #   Point3d arg2 --- Origin [IN]
  #   BOOL arg3 --- IsPointCell [IN]
  def CreateSharedCellElement1(arg0, arg1, arg2, arg3 = nil)
    ret = _invoke(1610744002, [arg0, arg1, arg2, arg3], [VT_BSTR, VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _SharedCellElement CreateSharedCellElement2
  #   BSTR arg0 --- CellName [IN]
  #   Point3d arg1 --- Origin [IN/OUT]
  #   Point3d arg2 --- Scale [IN/OUT]
  #   BOOL arg3 --- TrueScale [IN]
  #   Matrix3d arg4 --- Rotation [IN/OUT]
  def CreateSharedCellElement2(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744003, [arg0, arg1, arg2, arg3, arg4], [VT_BSTR, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BOOL, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _SharedCellElement CreateSharedCellElement3
  #   BSTR arg0 --- CellName [IN]
  #   Point3d arg1 --- Origin [IN/OUT]
  #   BOOL arg2 --- TrueScale [IN]
  def CreateSharedCellElement3(arg0, arg1, arg2)
    ret = _invoke(1610744004, [arg0, arg1, arg2], [VT_BSTR, VT_BYREF | VT_DISPATCH, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID StartBusyCursor
  def StartBusyCursor
    ret = _invoke(1610744005, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID StopBusyCursor
  def StopBusyCursor
    ret = _invoke(1610744006, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _DatabaseLink CreateDatabaseLink
  #   INT arg0 --- Mslink [IN]
  #   INT arg1 --- Entity [IN]
  #   MsdDatabaseLinkage arg2 --- LinkType [IN]
  #   BOOL arg3 --- IsInformation [IN]
  #   INT arg4 --- DisplayableAttributeType [IN]
  def CreateDatabaseLink(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744009, [arg0, arg1, arg2, arg3, arg4], [VT_I4, VT_I4, VT_DISPATCH, VT_BOOL, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _HatchPattern CreateHatchPattern1
  #   R8 arg0 --- Space [IN]
  #   R8 arg1 --- Angle [IN]
  def CreateHatchPattern1(arg0, arg1)
    ret = _invoke(1610744010, [arg0, arg1], [VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _CrossHatchPattern CreateCrossHatchPattern
  #   R8 arg0 --- Space1 [IN]
  #   R8 arg1 --- Space2 [IN]
  #   R8 arg2 --- Angle1 [IN]
  #   R8 arg3 --- Angle2 [IN]
  def CreateCrossHatchPattern(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744011, [arg0, arg1, arg2, arg3], [VT_R8, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _AreaPattern CreateAreaPattern
  #   R8 arg0 --- RowSpacing [IN]
  #   R8 arg1 --- ColSpacing [IN]
  #   R8 arg2 --- Angle [IN]
  #   BSTR arg3 --- CellName [IN]
  #   R8 arg4 --- Scale [IN]
  def CreateAreaPattern(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744012, [arg0, arg1, arg2, arg3, arg4], [VT_R8, VT_R8, VT_R8, VT_BSTR, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR DLongToString
  #   DLong arg0 --- Value [IN]
  def DLongToString(arg0)
    ret = _invoke(1610744013, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BSTR DLongToHexString
  #   DLong arg0 --- Value [IN]
  def DLongToHexString(arg0)
    ret = _invoke(1610744014, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongFromString
  #   BSTR arg0 --- Value [IN]
  def DLongFromString(arg0)
    ret = _invoke(1610744015, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongFromHexString
  #   BSTR arg0 --- Value [IN]
  def DLongFromHexString(arg0)
    ret = _invoke(1610744016, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongFromLong
  #   INT arg0 --- Value [IN]
  def DLongFromLong(arg0)
    ret = _invoke(1610744017, [arg0], [VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT DLongToLong
  #   DLong arg0 --- Value [IN/OUT]
  def DLongToLong(arg0)
    ret = _invoke(1610744018, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT DLongComp
  #   DLong arg0 --- Value1 [IN/OUT]
  #   DLong arg1 --- Value2 [IN/OUT]
  def DLongComp(arg0, arg1)
    ret = _invoke(1610744019, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongAdd
  #   DLong arg0 --- Term1 [IN/OUT]
  #   DLong arg1 --- Term2 [IN/OUT]
  def DLongAdd(arg0, arg1)
    ret = _invoke(1610744020, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongSubtract
  #   DLong arg0 --- Minuend [IN/OUT]
  #   DLong arg1 --- Subtrahend [IN/OUT]
  def DLongSubtract(arg0, arg1)
    ret = _invoke(1610744021, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongMultiply
  #   DLong arg0 --- Factor1 [IN/OUT]
  #   DLong arg1 --- Factor2 [IN/OUT]
  def DLongMultiply(arg0, arg1)
    ret = _invoke(1610744022, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongDivide
  #   DLong arg0 --- Numerator [IN/OUT]
  #   DLong arg1 --- Denominator [IN/OUT]
  def DLongDivide(arg0, arg1)
    ret = _invoke(1610744023, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongMod
  #   DLong arg0 --- Numerator [IN/OUT]
  #   DLong arg1 --- Denominator [IN/OUT]
  def DLongMod(arg0, arg1)
    ret = _invoke(1610744024, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongNegate
  #   DLong arg0 --- Value [IN/OUT]
  def DLongNegate(arg0)
    ret = _invoke(1610744025, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongAbs
  #   DLong arg0 --- Value [IN/OUT]
  def DLongAbs(arg0)
    ret = _invoke(1610744026, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DataEntryRegion DataEntryRegionFromCriteria
  #   INT arg0 --- StartPosition [IN]
  #   INT arg1 --- Length [IN]
  #   MsdDataEntryRegionJustification arg2 --- Justification [IN]
  def DataEntryRegionFromCriteria(arg0, arg1, arg2)
    ret = _invoke(1610744027, [arg0, arg1, arg2], [VT_I4, VT_I4, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Quit
  def Quit
    ret = _invoke(1610744041, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddModalDialogEventsHandler
  #   IModalDialogEvents arg0 --- EventHandler [IN]
  def AddModalDialogEventsHandler(arg0)
    ret = _invoke(1610744042, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveModalDialogEventsHandler
  #   IModalDialogEvents arg0 --- EventHandler [IN]
  def RemoveModalDialogEventsHandler(arg0)
    ret = _invoke(1610744043, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Atn2
  #   R8 arg0 --- Y [IN]
  #   R8 arg1 --- X [IN]
  def Atn2(arg0, arg1)
    ret = _invoke(1610744046, [arg0, arg1], [VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongFromInt64
  #   I8 arg0 --- Value [IN]
  def DLongFromInt64(arg0)
    ret = _invoke(1610744047, [arg0], ["??? NOT SUPPORTED TYPE:`I8'"])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # I8 DLongToInt64
  #   DLong arg0 --- Value [IN/OUT]
  def DLongToInt64(arg0)
    ret = _invoke(1610744048, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _Element MdlCreateElementFromElementDescrP
  #   INT arg0 --- ElementDescrP [IN]
  def MdlCreateElementFromElementDescrP(arg0)
    ret = _invoke(1610744049, [arg0], [VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ModelReference MdlGetModelReferenceFromModelRefP
  #   INT arg0 --- ModelRefP [IN]
  def MdlGetModelReferenceFromModelRefP(arg0)
    ret = _invoke(1610744050, [arg0], [VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _DesignFile MdlGetDesignFileFromModelRefP
  #   INT arg0 --- ModelRefP [IN]
  def MdlGetDesignFileFromModelRefP(arg0)
    ret = _invoke(1610744051, [arg0], [VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dIsXYRotationSkewAndScale
  # method Matrix3dIsXYRotationSkewAndScale
  #   Matrix3d arg0 --- Matrix [IN]
  #   R8 arg1 --- XAxisAngle [IN/OUT]
  #   R8 arg2 --- YAxisSkewAngle [IN/OUT]
  #   R8 arg3 --- Xscale [IN/OUT]
  #   R8 arg4 --- Yscale [IN/OUT]
  #   R8 arg5 --- Zscale [IN/OUT]
  def Matrix3dIsXYRotationSkewAndScale(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610744052, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8, VT_BYREF | VT_R8, VT_BYREF | VT_R8, VT_BYREF | VT_R8, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromXYRotationSkewAndScale
  # method Matrix3dFromXYRotationSkewAndScale
  #   R8 arg0 --- XAxisAngle [IN]
  #   R8 arg1 --- YAxisSkewAngle [IN]
  #   R8 arg2 --- Xscale [IN]
  #   R8 arg3 --- Yscale [IN]
  #   R8 arg4 --- Zscale [IN]
  def Matrix3dFromXYRotationSkewAndScale(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744053, [arg0, arg1, arg2, arg3, arg4], [VT_R8, VT_R8, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dIsXYRotation
  # method Matrix3dIsXYRotation
  #   Matrix3d arg0 --- Matrix [IN]
  #   R8 arg1 --- XYRotationRadians [IN/OUT]
  def Matrix3dIsXYRotation(arg0, arg1)
    ret = _invoke(1610744054, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromMirrorPlane
  # method Transform3dFromMirrorPlane
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Normal [IN]
  def Transform3dFromMirrorPlane(arg0, arg1)
    ret = _invoke(1610744055, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT UpdateGraphicGroupNumber
  def UpdateGraphicGroupNumber
    ret = _invoke(1610744056, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _PointStringElement CreatePointStringElement1
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- Vertices [IN/OUT]
  #   BOOL arg2 --- Disjoint [IN]
  def CreatePointStringElement1(arg0, arg1, arg2)
    ret = _invoke(1610744058, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_ARRAY | VT_DISPATCH, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ArcElement CreateArcElement3
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- StartPoint [IN/OUT]
  #   Point3d arg2 --- PointOnCurve [IN/OUT]
  #   Point3d arg3 --- EndPoint [IN/OUT]
  def CreateArcElement3(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744059, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAddAngleDistance
  # method Point3dAddAngleDistance
  #   Point3d arg0 --- Point1 [IN]
  #   R8 arg1 --- AngleRadians [IN]
  #   R8 arg2 --- DistanceXY [IN]
  #   R8 arg3 --- Dz [IN]
  def Point3dAddAngleDistance(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744060, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromAngleDistance
  # method Point3dFromAngleDistance
  #   R8 arg0 --- AngleRadians [IN]
  #   R8 arg1 --- DistanceXY [IN]
  #   R8 arg2 --- Z [IN]
  def Point3dFromAngleDistance(arg0, arg1, arg2)
    ret = _invoke(1610744061, [arg0, arg1, arg2], [VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dPolarAngle
  # method Point3dPolarAngle
  #   Point3d arg0 --- Vector [IN]
  def Point3dPolarAngle(arg0)
    ret = _invoke(1610744062, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddChangeTrackEventsHandler
  #   IChangeTrackEvents arg0 --- EventHandler [IN]
  def AddChangeTrackEventsHandler(arg0)
    ret = _invoke(1610744065, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveChangeTrackEventsHandler
  #   IChangeTrackEvents arg0 --- EventHandler [IN]
  def RemoveChangeTrackEventsHandler(arg0)
    ret = _invoke(1610744066, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddAttachmentEventsHandler
  #   IAttachmentEvents arg0 --- EventHandler [IN]
  def AddAttachmentEventsHandler(arg0)
    ret = _invoke(1610744067, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveAttachmentEventsHandler
  #   IAttachmentEvents arg0 --- EventHandler [IN]
  def RemoveAttachmentEventsHandler(arg0)
    ret = _invoke(1610744068, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dIsRotateScaleRotate
  # method Matrix3dIsRotateScaleRotate
  #   Matrix3d arg0 --- Matrix [IN]
  #   Matrix3d arg1 --- Rotation1 [IN/OUT]
  #   Point3d arg2 --- ScaleFactors [IN/OUT]
  #   Matrix3d arg3 --- Rotation2 [IN/OUT]
  def Matrix3dIsRotateScaleRotate(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744069, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsTranslateRotateScaleRotate
  # method Transform3ddIsTranslateRotateScaleRotate
  #   Transform3d arg0 --- Transform [IN]
  #   Point3d arg1 --- Translation [IN/OUT]
  #   Matrix3d arg2 --- Rotation1 [IN/OUT]
  #   Point3d arg3 --- ScaleFactors [IN/OUT]
  #   Matrix3d arg4 --- Rotation2 [IN/OUT]
  def Transform3dIsTranslateRotateScaleRotate(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744070, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsTranslate
  # method Transform3ddIsTranslate
  #   Transform3d arg0 --- Transform [IN]
  #   Point3d arg1 --- Translation [IN/OUT]
  def Transform3dIsTranslate(arg0, arg1)
    ret = _invoke(1610744071, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsUniformScale
  # method Transform3ddIsUniformScale
  #   Transform3d arg0 --- Transform [IN]
  #   Point3d arg1 --- FixedPoint [IN/OUT]
  #   R8 arg2 --- Scale [IN/OUT]
  def Transform3dIsUniformScale(arg0, arg1, arg2)
    ret = _invoke(1610744072, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsRotateAroundLine
  # method Transform3ddIsRotateAroundLine
  #   Transform3d arg0 --- Transform [IN]
  #   Point3d arg1 --- FixedPoint [IN/OUT]
  #   Point3d arg2 --- DirectionVector [IN/OUT]
  #   R8 arg3 --- Radians [IN/OUT]
  def Transform3dIsRotateAroundLine(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744073, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsMirrorAboutPlane
  # method Transform3dIsMirrorAboutPlane
  #   Transform3d arg0 --- Transform [IN]
  #   Point3d arg1 --- PlanePoint [IN/OUT]
  #   Point3d arg2 --- PlaneNormal [IN/OUT]
  def Transform3dIsMirrorAboutPlane(arg0, arg1, arg2)
    ret = _invoke(1610744074, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dIsUniformScaleAndRotateAroundLine
  # method Transform3ddIsUniformScaleAndRotateAroundLine
  #   Transform3d arg0 --- Transform [IN]
  #   Point3d arg1 --- FixedPoint [IN/OUT]
  #   Point3d arg2 --- DirectionVector [IN/OUT]
  #   R8 arg3 --- Radians [IN/OUT]
  #   R8 arg4 --- Scale [IN/OUT]
  def Transform3dIsUniformScaleAndRotateAroundLine(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744075, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Transform3dFactorMirror
  # method Transform3dFactorMirror
  #   Transform3d arg0 --- Transform [IN]
  #   Transform3d arg1 --- ResidualTransform [IN/OUT]
  #   Transform3d arg2 --- MirrorTransform [IN/OUT]
  #   Point3d arg3 --- FixedPoint [IN/OUT]
  #   Point3d arg4 --- PlaneNormal [IN/OUT]
  def Transform3dFactorMirror(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744076, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dInit
  # method Range3dInit
  def Range3dInit
    ret = _invoke(1610744077, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Range3dIsNull
  # method Range3dIsNull
  #   Range3d arg0 --- Range [IN]
  def Range3dIsNull(arg0)
    ret = _invoke(1610744078, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Range3dExtentSquared
  # method Range3dExtentSquared
  #   Range3d arg0 --- Range [IN]
  def Range3dExtentSquared(arg0)
    ret = _invoke(1610744079, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dFromPoint3d
  # method Range3dFromPoint3d
  #   Point3d arg0 --- Point [IN]
  def Range3dFromPoint3d(arg0)
    ret = _invoke(1610744080, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dFromPoint3dPoint3d
  # method Range3dFromPoint3dPoint3d
  #   Point3d arg0 --- Point0 [IN]
  #   Point3d arg1 --- Point1 [IN]
  def Range3dFromPoint3dPoint3d(arg0, arg1)
    ret = _invoke(1610744081, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dFromXYZXYZ
  # method Range3dFromXYZXYZ
  #   R8 arg0 --- X1 [IN]
  #   R8 arg1 --- Y1 [IN]
  #   R8 arg2 --- Z1 [IN]
  #   R8 arg3 --- X2 [IN]
  #   R8 arg4 --- Y2 [IN]
  #   R8 arg5 --- Z2 [IN]
  def Range3dFromXYZXYZ(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610744082, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dFromXYZ
  # method Range3dFromXYZ
  #   R8 arg0 --- X [IN]
  #   R8 arg1 --- Y [IN]
  #   R8 arg2 --- Z [IN]
  def Range3dFromXYZ(arg0, arg1, arg2)
    ret = _invoke(1610744083, [arg0, arg1, arg2], [VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dFromPoint3dPoint3dPoint3d
  # method Range3dFromPoint3dPoint3dPoint3d
  #   Point3d arg0 --- Point0 [IN]
  #   Point3d arg1 --- Point1 [IN]
  #   Point3d arg2 --- Point2 [IN]
  def Range3dFromPoint3dPoint3dPoint3d(arg0, arg1, arg2)
    ret = _invoke(1610744084, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dFromRange3dMargin
  # method Range3dFromRange3dMargin
  #   Range3d arg0 --- Range [IN]
  #   R8 arg1 --- Margin [IN]
  def Range3dFromRange3dMargin(arg0, arg1)
    ret = _invoke(1610744085, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dUnionPoint3d
  # method Range3dUnionPoint3d
  #   Range3d arg0 --- Range [IN]
  #   Point3d arg1 --- Point [IN]
  def Range3dUnionPoint3d(arg0, arg1)
    ret = _invoke(1610744086, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dUnionXYZ
  # method Range3dUnionXYZ
  #   Range3d arg0 --- Range [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Range3dUnionXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744087, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dUnion
  # method Range3dUnion
  #   Range3d arg0 --- Range0 [IN]
  #   Range3d arg1 --- Range1 [IN]
  def Range3dUnion(arg0, arg1)
    ret = _invoke(1610744088, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dIntersect
  # method Range3dIntersect
  #   Range3d arg0 --- Range1 [IN]
  #   Range3d arg1 --- Range2 [IN]
  def Range3dIntersect(arg0, arg1)
    ret = _invoke(1610744089, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Range3dIsContainedInRange3d
  # method Range3dIsContainedInRange3d
  #   Range3d arg0 --- InnerRange [IN]
  #   Range3d arg1 --- OuterRange [IN]
  def Range3dIsContainedInRange3d(arg0, arg1)
    ret = _invoke(1610744090, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Range3dContainsPoint3d
  # method Range3dContainsPoint3d
  #   Range3d arg0 --- Range [IN]
  #   Point3d arg1 --- Point [IN]
  def Range3dContainsPoint3d(arg0, arg1)
    ret = _invoke(1610744091, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Range3dContainsXYZ
  # method Range3dContainsXYZ
  #   Range3d arg0 --- Range [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Range3dContainsXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744092, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Range3dEqual
  # method Range3dEqual
  #   Range3d arg0 --- Range1 [IN]
  #   Range3d arg1 --- Range2 [IN]
  def Range3dEqual(arg0, arg1)
    ret = _invoke(1610744093, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Range3dEqualTolerance
  # method Range3dEqualTolerance
  #   Range3d arg0 --- Range0 [IN]
  #   Range3d arg1 --- Range1 [IN]
  #   R8 arg2 --- Tolerance [IN]
  def Range3dEqualTolerance(arg0, arg1, arg2)
    ret = _invoke(1610744094, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Range3d Range3dScaleAboutCenter
  # method Range3dScaleAboutCenter
  #   Range3d arg0 --- RangeIn [IN]
  #   R8 arg1 --- Scale [IN]
  def Range3dScaleAboutCenter(arg0, arg1)
    ret = _invoke(1610744095, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AppendXDatum
  #   XDatum arg0 --- XData [IN/OUT]
  #   MsdXDatumType arg1 --- Type [IN]
  #   VARIANT arg2 --- Value [IN]
  def AppendXDatum(arg0, arg1, arg2)
    ret = _invoke(1610744098, [arg0, arg1, arg2], [VT_BYREF | VT_ARRAY | VT_DISPATCH, VT_DISPATCH, VT_VARIANT])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID InsertXDatum
  #   XDatum arg0 --- XData [IN/OUT]
  #   INT arg1 --- Index [IN]
  #   MsdXDatumType arg2 --- Type [IN]
  #   VARIANT arg3 --- Value [IN]
  def InsertXDatum(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744099, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_ARRAY | VT_DISPATCH, VT_I4, VT_DISPATCH, VT_VARIANT])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID DeleteXDatum
  #   XDatum arg0 --- XData [IN/OUT]
  #   INT arg1 --- Index [IN]
  def DeleteXDatum(arg0, arg1)
    ret = _invoke(1610744100, [arg0, arg1], [VT_BYREF | VT_ARRAY | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ApplicationElement CreateApplicationElement
  #   I4 arg0 --- ApplicationID [IN]
  #   _DataBlock arg1 --- ApplicationData [IN]
  def CreateApplicationElement(arg0, arg1)
    ret = _invoke(1610744102, [arg0, arg1], [VT_I4, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddSaveAsEventsHandler
  #   ISaveAsEvents arg0 --- EventsHandler [IN]
  def AddSaveAsEventsHandler(arg0)
    ret = _invoke(1610744104, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveSaveAsEventsHandler
  #   ISaveAsEvents arg0 --- EventsHandler [IN]
  def RemoveSaveAsEventsHandler(arg0)
    ret = _invoke(1610744105, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT ByLevelColor
  def ByLevelColor
    ret = _invoke(1610744106, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT ByCellColor
  def ByCellColor
    ret = _invoke(1610744107, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT ByLevelLineWeight
  def ByLevelLineWeight
    ret = _invoke(1610744108, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT ByCellLineWeight
  def ByCellLineWeight
    ret = _invoke(1610744109, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _LineStyle ByLevelLineStyle
  def ByLevelLineStyle
    ret = _invoke(1610744110, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _LineStyle ByCellLineStyle
  def ByCellLineStyle
    ret = _invoke(1610744111, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID ResetDisplaySet
  #   BOOL arg0 --- ShowEverything [IN]
  def ResetDisplaySet(arg0)
    ret = _invoke(1610744112, [arg0], [VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # I4 PointsToPixelsX
  #   R8 arg0 --- PointCoordinate [IN]
  def PointsToPixelsX(arg0)
    ret = _invoke(1610744113, [arg0], [VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # I4 PointsToPixelsY
  #   R8 arg0 --- PointCoordinate [IN]
  def PointsToPixelsY(arg0)
    ret = _invoke(1610744114, [arg0], [VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # I4 ApplyHorizontalScalingFixForEMF
  #   R8 arg0 --- PixelCoordinate [IN]
  def ApplyHorizontalScalingFixForEMF(arg0)
    ret = _invoke(1610744115, [arg0], [VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # I4 ApplyVerticalScalingFixForEMF
  #   R8 arg0 --- PixelCoordinate [IN]
  def ApplyVerticalScalingFixForEMF(arg0)
    ret = _invoke(1610744116, [arg0], [VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _TextNodeElement CreateTextNodeElement2
  #   _Element arg0 --- Template [IN]
  #   Point3d arg1 --- Origin [IN/OUT]
  #   Matrix3d arg2 --- Rotation [IN/OUT]
  #   BOOL arg3 --- IncrementNodeNumber [IN] ( = true)
  #   UNKNOWN arg4 --- Reserved [IN]
  def CreateTextNodeElement2(arg0, arg1, arg2, arg3 = nil, arg4 = nil)
    ret = _invoke(1610744119, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BOOL, VT_UNKNOWN])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _BsplineCurveElement CreateBsplineCurveElement1
  #   _Element arg0 --- Template [IN]
  #   _BsplineCurve arg1 --- Curve [IN]
  def CreateBsplineCurveElement1(arg0, arg1)
    ret = _invoke(1610744121, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _BsplineCurveElement CreateBsplineCurveElement2
  #   _Element arg0 --- Template [IN]
  #   _InterpolationCurve arg1 --- Curve [IN]
  def CreateBsplineCurveElement2(arg0, arg1)
    ret = _invoke(1610744122, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _BsplineSurfaceElement CreateBsplineSurfaceElement1
  #   _Element arg0 --- Template [IN]
  #   _BsplineSurface arg1 --- Surface [IN]
  def CreateBsplineSurfaceElement1(arg0, arg1)
    ret = _invoke(1610744123, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dProjectToPlane3d
  #   Point3d arg0 --- Point [IN/OUT]
  #   Plane3d arg1 --- Plane [IN/OUT]
  #   VARIANT arg2 --- ViewSpecifier [IN] ( = 0)
  #   BOOL arg3 --- UseAuxiliaryCoordinateSystem [IN]
  def Point3dProjectToPlane3d(arg0, arg1, arg2 = nil, arg3 = nil)
    ret = _invoke(1610744125, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_VARIANT, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dProjectToRay3d
  #   R8 arg0 --- Parameter [IN/OUT]
  #   Point3d arg1 --- Point [IN/OUT]
  #   Ray3d arg2 --- Ray [IN/OUT]
  #   VARIANT arg3 --- ViewSpecifier [IN] ( = 0)
  #   BOOL arg4 --- UseAuxiliaryCoordinateSystem [IN]
  def Point3dProjectToRay3d(arg0, arg1, arg2, arg3 = nil, arg4 = nil)
    ret = _invoke(1610744126, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_R8, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_VARIANT, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ArcElement CreateArcElement4
  #   _Element arg0 --- Template [IN]
  #   Ray3d arg1 --- StartTangent [IN/OUT]
  #   Point3d arg2 --- EndPoint [IN/OUT]
  def CreateArcElement4(arg0, arg1, arg2)
    ret = _invoke(1610744127, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ArcElement CreateArcElement5
  #   _Element arg0 --- Template [IN]
  #   Segment3d arg1 --- Chord [IN/OUT]
  #   R8 arg2 --- ArcLength [IN]
  #   Point3d arg3 --- PlanePoint [IN/OUT]
  def CreateArcElement5(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744128, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _Element CreateEllipticalElement1
  #   _Element arg0 --- Template [IN]
  #   Ellipse3d arg1 --- Ellipse [IN/OUT]
  #   MsdFillMode arg2 --- FillMode [IN] ( = -1)
  def CreateEllipticalElement1(arg0, arg1, arg2 = nil)
    ret = _invoke(1610744129, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Ellipse3d Ellipse3dFromEllipticalElement
  #   EllipticalElement arg0 --- Element [IN]
  def Ellipse3dFromEllipticalElement(arg0)
    ret = _invoke(1610744130, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ElementEnumerator ConstructCirclesTangentToThreeElements
  #   _Element arg0 --- Element1 [IN]
  #   _Element arg1 --- Element2 [IN]
  #   _Element arg2 --- Element3 [IN]
  #   _Element arg3 --- Template [IN]
  #   MsdTangentElementOutputType arg4 --- OutputType [IN] ( = 0)
  #   INT arg5 --- SamplesCount [IN] ( = 10)
  def ConstructCirclesTangentToThreeElements(arg0, arg1, arg2, arg3, arg4 = nil, arg5 = nil)
    ret = _invoke(1610744131, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # INT Point3dInPolygonXY
  #   Point3d arg0 --- Point [IN/OUT]
  #   Point3d arg1 --- PolygonVertices [IN/OUT]
  #   R8 arg2 --- Tolerance [IN] ( = -1.0)
  def Point3dInPolygonXY(arg0, arg1, arg2 = nil)
    ret = _invoke(1610744132, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_ARRAY | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dZero
  def Transform3dZero
    ret = _invoke(1610744135, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ComplexShapeElement CreateComplexShapeElement2
  #   ChainableElement arg0 --- ChainableElements [IN/OUT]
  #   MsdFillMode arg1 --- FillMode [IN] ( = -1)
  #   R8 arg2 --- GapTolerance [IN] ( = -1.0)
  def CreateComplexShapeElement2(arg0, arg1 = nil, arg2 = nil)
    ret = _invoke(1610744136, [arg0, arg1, arg2], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ComplexStringElement CreateComplexStringElement2
  #   ChainableElement arg0 --- ChainableElements [IN/OUT]
  #   R8 arg1 --- GapTolerance [IN] ( = -1.0)
  def CreateComplexStringElement2(arg0, arg1 = nil)
    ret = _invoke(1610744137, [arg0, arg1], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _DesignFile OpenDesignFileForProgram
  #   BSTR arg0 --- DesignFileName [IN]
  #   BOOL arg1 --- ReadOnly [IN]
  def OpenDesignFileForProgram(arg0, arg1 = nil)
    ret = _invoke(1610744138, [arg0, arg1], [VT_BSTR, VT_BOOL])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # DLong DLongFromDouble
  #   R8 arg0 --- Value [IN]
  def DLongFromDouble(arg0)
    ret = _invoke(1610744139, [arg0], [VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID SaveSettings
  def SaveSettings
    ret = _invoke(1610744140, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # UNKNOWN CreateObjectInMicroStation
  #   BSTR arg0 --- ProgID [IN]
  def CreateObjectInMicroStation(arg0)
    ret = _invoke(1610744145, [arg0], [VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dRotationFromRowZ
  #   Point3d arg0 --- Normal [IN/OUT]
  def Matrix3dRotationFromRowZ(arg0)
    ret = _invoke(1610744146, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dRotationFromColumnZ
  #   Point3d arg0 --- Normal [IN/OUT]
  def Matrix3dRotationFromColumnZ(arg0)
    ret = _invoke(1610744147, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromWorldToPlane3d
  #   Plane3d arg0 --- Plane [IN/OUT]
  def Transform3dFromWorldToPlane3d(arg0)
    ret = _invoke(1610744148, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromPlane3dToWorld
  #   Plane3d arg0 --- Plane [IN/OUT]
  def Transform3dFromPlane3dToWorld(arg0)
    ret = _invoke(1610744149, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Matrix3dIsXRotationYRotationZRotationScale
  # method Matrix3dIsXRotationYRotationZRotationScale
  #   Matrix3d arg0 --- Matrix [IN]
  #   R8 arg1 --- RadiansX [IN/OUT]
  #   R8 arg2 --- RadiansY [IN/OUT]
  #   R8 arg3 --- RadiansZ [IN/OUT]
  #   R8 arg4 --- Scale [IN/OUT]
  def Matrix3dIsXRotationYRotationZRotationScale(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744150, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8, VT_BYREF | VT_R8, VT_BYREF | VT_R8, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _Element GetFloodBoundary
  #   _Element arg0 --- CandidateElements [IN/OUT]
  #   _Element arg1 --- Template [IN]
  #   Point3d arg2 --- SeedPoint [IN/OUT]
  #   VARIANT arg3 --- ViewSpecifier [IN] ( = 0)
  #   BOOL arg4 --- FindHoles [IN] ( = true)
  #   R8 arg5 --- Tolerance [IN] ( = -1.0)
  #   MsdFillMode arg6 --- FillMode [IN] ( = -1)
  def GetFloodBoundary(arg0, arg1, arg2, arg3 = nil, arg4 = nil, arg5 = nil, arg6 = nil)
    ret = _invoke(1610744151, [arg0, arg1, arg2, arg3, arg4, arg5, arg6], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_VARIANT, VT_BOOL, VT_R8, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ElementEnumerator GetRegionUnion
  #   _Element arg0 --- Region1 [IN/OUT]
  #   _Element arg1 --- Region2 [IN/OUT]
  #   _Element arg2 --- Template [IN]
  #   MsdFillMode arg3 --- FillMode [IN] ( = -1)
  def GetRegionUnion(arg0, arg1, arg2, arg3 = nil)
    ret = _invoke(1610744152, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ElementEnumerator GetRegionDifference
  #   _Element arg0 --- RegionSolid [IN/OUT]
  #   _Element arg1 --- RegionHoles [IN/OUT]
  #   _Element arg2 --- Template [IN]
  #   MsdFillMode arg3 --- FillMode [IN] ( = -1)
  def GetRegionDifference(arg0, arg1, arg2, arg3 = nil)
    ret = _invoke(1610744153, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ElementEnumerator GetRegionIntersection
  #   _Element arg0 --- Region1 [IN/OUT]
  #   _Element arg1 --- Region2 [IN/OUT]
  #   _Element arg2 --- Template [IN]
  #   MsdFillMode arg3 --- FillMode [IN] ( = -1)
  def GetRegionIntersection(arg0, arg1, arg2, arg3 = nil)
    ret = _invoke(1610744154, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dCrossProduct
  # method Vector3dCrossProduct
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dCrossProduct(arg0, arg1)
    ret = _invoke(1610744156, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dCrossProduct3Points
  # method Vector3dCrossProduct3Points
  #   Point3d arg0 --- Origin [IN]
  #   Point3d arg1 --- Target1 [IN]
  #   Point3d arg2 --- Target2 [IN]
  def Vector3dCrossProduct3Points(arg0, arg1, arg2)
    ret = _invoke(1610744157, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dCrossProductXY
  # method Vector3dCrossProductXY
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dCrossProductXY(arg0, arg1)
    ret = _invoke(1610744158, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dTripleProduct
  # method Vector3dTripleProduct
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  #   Vector3d arg2 --- Vector3 [IN]
  def Vector3dTripleProduct(arg0, arg1, arg2)
    ret = _invoke(1610744159, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dDotProduct
  # method Vector3dDotProduct
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dDotProduct(arg0, arg1)
    ret = _invoke(1610744160, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dDotProductXY
  # method Vector3dDotProductXY
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dDotProductXY(arg0, arg1)
    ret = _invoke(1610744161, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dDotProductXYZ
  # method Vector3dDotProductXYZ
  #   Vector3d arg0 --- Vector [IN]
  #   R8 arg1 --- Ax [IN]
  #   R8 arg2 --- Ay [IN]
  #   R8 arg3 --- Az [IN]
  def Vector3dDotProductXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744162, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dAngleBetweenVectors
  # method Vector3dAngleBetweenVectors
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dAngleBetweenVectors(arg0, arg1)
    ret = _invoke(1610744163, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dSmallerAngleBetweenUnorientedVectors
  # method Vector3dSmallerAngleBetweenUnorientedVectors
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dSmallerAngleBetweenUnorientedVectors(arg0, arg1)
    ret = _invoke(1610744164, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Vector3dIsVectorInSmallerSector
  # method Vector3dIsVectorInSmallerSector
  #   Vector3d arg0 --- TestVector [IN]
  #   Vector3d arg1 --- Vector0 [IN]
  #   Vector3d arg2 --- Vector1 [IN]
  def Vector3dIsVectorInSmallerSector(arg0, arg1, arg2)
    ret = _invoke(1610744165, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Vector3dIsVectorInCCWSector
  # method Vector3dIsVectorInCCWSector
  #   Vector3d arg0 --- TestVector [IN]
  #   Vector3d arg1 --- Vector0 [IN]
  #   Vector3d arg2 --- Vector1 [IN]
  #   Vector3d arg3 --- UpVector [IN]
  def Vector3dIsVectorInCCWSector(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744166, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Vector3dIsVectorInCCWXYSector
  # method Vector3dIsVectorInCCWXYSector
  #   Vector3d arg0 --- TestVector [IN]
  #   Vector3d arg1 --- Vector0 [IN]
  #   Vector3d arg2 --- Vector1 [IN]
  def Vector3dIsVectorInCCWXYSector(arg0, arg1, arg2)
    ret = _invoke(1610744167, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dAngleBetweenVectorsXY
  # method Vector3dAngleBetweenVectorsXY
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dAngleBetweenVectorsXY(arg0, arg1)
    ret = _invoke(1610744168, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dSmallerAngleBetweenUnorientedVectorsXY
  # method Vector3dSmallerAngleBetweenUnorientedVectorsXY
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dSmallerAngleBetweenUnorientedVectorsXY(arg0, arg1)
    ret = _invoke(1610744169, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dRotateXY
  # method Vector3dRotateXY
  #   Vector3d arg0 --- Vector [IN]
  #   R8 arg1 --- Theta [IN]
  def Vector3dRotateXY(arg0, arg1)
    ret = _invoke(1610744170, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dSignedAngleBetweenVectors
  # method Vector3dSignedAngleBetweenVectors
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  #   Vector3d arg2 --- OrientationVector [IN]
  def Vector3dSignedAngleBetweenVectors(arg0, arg1, arg2)
    ret = _invoke(1610744171, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dPlanarAngleBetweenVectors
  # method Vector3dPlanarAngleBetweenVectors
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  #   Vector3d arg2 --- PlaneNormal [IN]
  def Vector3dPlanarAngleBetweenVectors(arg0, arg1, arg2)
    ret = _invoke(1610744172, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dMagnitudeSquared
  # method Vector3dMagnitudeSquared
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dMagnitudeSquared(arg0)
    ret = _invoke(1610744173, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dMagnitudeXY
  # method Vector3dMagnitudeXY
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dMagnitudeXY(arg0)
    ret = _invoke(1610744174, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dMagnitudeSquaredXY
  # method Vector3dMagnitudeSquaredXY
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dMagnitudeSquaredXY(arg0)
    ret = _invoke(1610744175, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dUnitPerpendicularXY
  # method Vector3dUnitPerpendicularXY
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dUnitPerpendicularXY(arg0)
    ret = _invoke(1610744176, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dMagnitude
  # method Vector3dMagnitude
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dMagnitude(arg0)
    ret = _invoke(1610744177, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dScale
  # method Vector3dScale
  #   Vector3d arg0 --- Vector [IN]
  #   R8 arg1 --- Scale [IN]
  def Vector3dScale(arg0, arg1)
    ret = _invoke(1610744178, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dNegate
  # method Vector3dNegate
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dNegate(arg0)
    ret = _invoke(1610744179, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dNormalize
  # method Vector3dNormalize
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dNormalize(arg0)
    ret = _invoke(1610744180, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Vector3dAreVectorsParallel
  # method Vector3dAreVectorsParallel
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dAreVectorsParallel(arg0, arg1)
    ret = _invoke(1610744181, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Vector3dAreVectorsPerpendicular
  # method Vector3dAreVectorsPerpendicular
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dAreVectorsPerpendicular(arg0, arg1)
    ret = _invoke(1610744182, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dPolarAngle
  # method Vector3dPolarAngle
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dPolarAngle(arg0)
    ret = _invoke(1610744183, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dZero
  # method Vector3dZero
  def Vector3dZero
    ret = _invoke(1610744184, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dOne
  # method Vector3dOne
  def Vector3dOne
    ret = _invoke(1610744185, [], [])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromXYZ
  # method Vector3dFromXYZ
  #   R8 arg0 --- Ax [IN]
  #   R8 arg1 --- Ay [IN]
  #   R8 arg2 --- Az [IN]
  def Vector3dFromXYZ(arg0, arg1, arg2)
    ret = _invoke(1610744186, [arg0, arg1, arg2], [VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromPoint3d
  # method Vector3dFromPoint3d
  #   Point3d arg0 --- Point [IN]
  def Vector3dFromPoint3d(arg0)
    ret = _invoke(1610744187, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromXY
  # method Vector3dFromXY
  #   R8 arg0 --- Ax [IN]
  #   R8 arg1 --- Ay [IN]
  def Vector3dFromXY(arg0, arg1)
    ret = _invoke(1610744188, [arg0, arg1], [VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromXYAngleAndMagnitude
  # method Vector3dFromXYAngleAndMagnitude
  #   R8 arg0 --- Theta [IN]
  #   R8 arg1 --- Magnitude [IN]
  def Vector3dFromXYAngleAndMagnitude(arg0, arg1)
    ret = _invoke(1610744189, [arg0, arg1], [VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dGetComponent
  # method Vector3dGetComponent
  #   Vector3d arg0 --- Vector [IN]
  #   INT arg1 --- Index [IN]
  def Vector3dGetComponent(arg0, arg1)
    ret = _invoke(1610744190, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dAdd
  # method Vector3dAdd
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dAdd(arg0, arg1)
    ret = _invoke(1610744191, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dAddScaled
  # method Vector3dAddScaled
  #   Vector3d arg0 --- Origin [IN]
  #   Vector3d arg1 --- Vector [IN]
  #   R8 arg2 --- Scale [IN]
  def Vector3dAddScaled(arg0, arg1, arg2)
    ret = _invoke(1610744192, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dInterpolate
  # method Vector3dInterpolate
  #   Vector3d arg0 --- Vector0 [IN]
  #   R8 arg1 --- FractionParameter [IN]
  #   Vector3d arg2 --- Vector1 [IN]
  def Vector3dInterpolate(arg0, arg1, arg2)
    ret = _invoke(1610744193, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dAdd2Scaled
  # method Vector3dAdd2Scaled
  #   Vector3d arg0 --- Origin [IN]
  #   Vector3d arg1 --- Vector1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Vector3d arg3 --- Vector2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  def Vector3dAdd2Scaled(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744194, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dAdd3Scaled
  # method Vector3dAdd3Scaled
  #   Vector3d arg0 --- Origin [IN]
  #   Vector3d arg1 --- Vector1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Vector3d arg3 --- Vector2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  #   Vector3d arg5 --- Vector3 [IN]
  #   R8 arg6 --- Scale3 [IN]
  def Vector3dAdd3Scaled(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    ret = _invoke(1610744195, [arg0, arg1, arg2, arg3, arg4, arg5, arg6], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dSubtract
  # method Vector3dSubtract
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dSubtract(arg0, arg1)
    ret = _invoke(1610744196, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dSubtractPoint3dPoint3d
  # method Vector3dSubtractPoint3dPoint3d
  #   Point3d arg0 --- Target [IN]
  #   Point3d arg1 --- Base [IN]
  def Vector3dSubtractPoint3dPoint3d(arg0, arg1)
    ret = _invoke(1610744197, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dDistance
  # method Vector3dDistance
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dDistance(arg0, arg1)
    ret = _invoke(1610744198, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dDistanceSquared
  # method Vector3dDistanceSquared
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dDistanceSquared(arg0, arg1)
    ret = _invoke(1610744199, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dDistanceSquaredXY
  # method Vector3dDistanceSquaredXY
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dDistanceSquaredXY(arg0, arg1)
    ret = _invoke(1610744200, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dDistanceXY
  # method Vector3dDistanceXY
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dDistanceXY(arg0, arg1)
    ret = _invoke(1610744201, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dMaxAbs
  # method Vector3dMaxAbs
  #   Vector3d arg0 --- Vector [IN]
  def Vector3dMaxAbs(arg0)
    ret = _invoke(1610744202, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Vector3dMaxAbsDifference
  # method Vector3dMaxAbsDifference
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dMaxAbsDifference(arg0, arg1)
    ret = _invoke(1610744203, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Vector3dEqual
  # method Vector3dEqual
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  def Vector3dEqual(arg0, arg1)
    ret = _invoke(1610744204, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Vector3dEqualTolerance
  # method Vector3dEqualTolerance
  #   Vector3d arg0 --- Vector1 [IN]
  #   Vector3d arg1 --- Vector2 [IN]
  #   R8 arg2 --- Tolerance [IN]
  def Vector3dEqualTolerance(arg0, arg1, arg2)
    ret = _invoke(1610744205, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Point3dDotDifferenceVector3d
  # method Point3dDotDifferenceVector3d
  #   Point3d arg0 --- Target [IN]
  #   Point3d arg1 --- Origin [IN]
  #   Vector3d arg2 --- Vector [IN]
  def Point3dDotDifferenceVector3d(arg0, arg1, arg2)
    ret = _invoke(1610744206, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromVector3d
  # method Point3dFromVector3d
  #   Vector3d arg0 --- Vector [IN]
  def Point3dFromVector3d(arg0)
    ret = _invoke(1610744207, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAddPoint3dVector3d
  # method Point3dAddPoint3dVector3d
  #   Point3d arg0 --- Base [IN]
  #   Vector3d arg1 --- Vector [IN]
  def Point3dAddPoint3dVector3d(arg0, arg1)
    ret = _invoke(1610744208, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dSubtractPoint3dVector3d
  # method Point3dSubtractPoint3dVector3d
  #   Point3d arg0 --- Base [IN]
  #   Vector3d arg1 --- Vector [IN]
  def Point3dSubtractPoint3dVector3d(arg0, arg1)
    ret = _invoke(1610744209, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAddScaledVector3d
  # method Point3dAddScaledVector3d
  #   Point3d arg0 --- Origin [IN]
  #   Vector3d arg1 --- Vector [IN]
  #   R8 arg2 --- Scale [IN]
  def Point3dAddScaledVector3d(arg0, arg1, arg2)
    ret = _invoke(1610744210, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAdd2ScaledVector3d
  # method Point3dAdd2ScaledVector3d
  #   Point3d arg0 --- Origin [IN]
  #   Vector3d arg1 --- Vector1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Vector3d arg3 --- Vector2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  def Point3dAdd2ScaledVector3d(arg0, arg1, arg2, arg3, arg4)
    ret = _invoke(1610744211, [arg0, arg1, arg2, arg3, arg4], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dAdd3ScaledVector3d
  # method Point3dAdd3ScaledVector3d
  #   Point3d arg0 --- Origin [IN]
  #   Vector3d arg1 --- Vector1 [IN]
  #   R8 arg2 --- Scale1 [IN]
  #   Vector3d arg3 --- Vector2 [IN]
  #   R8 arg4 --- Scale2 [IN]
  #   Vector3d arg5 --- Vector3 [IN]
  #   R8 arg6 --- Scale3 [IN]
  def Point3dAdd3ScaledVector3d(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    ret = _invoke(1610744212, [arg0, arg1, arg2, arg3, arg4, arg5, arg6], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8, VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromMatrix3dTimesVector3d
  # method Vector3dFromMatrix3dTimesVector3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Vector3d arg1 --- Vector [IN]
  def Vector3dFromMatrix3dTimesVector3d(arg0, arg1)
    ret = _invoke(1610744213, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromMatrix3dTransposeTimesVector3d
  # method Vector3dFromMatrix3dTransposeTimesVector3d
  #   Matrix3d arg0 --- Matrix [IN]
  #   Vector3d arg1 --- Vector [IN]
  def Vector3dFromMatrix3dTransposeTimesVector3d(arg0, arg1)
    ret = _invoke(1610744214, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromMatrix3dTimesXYZ
  # method Vector3dFromMatrix3dTimesXYZ
  #   Matrix3d arg0 --- Matrix [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Vector3dFromMatrix3dTimesXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744215, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromMatrix3dTransposeTimesXYZ
  # method Vector3dFromMatrix3dTransposeTimesXYZ
  #   Matrix3d arg0 --- Matrix [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Vector3dFromMatrix3dTransposeTimesXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744216, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromMatrix3dColumn
  # method Vector3dFromMatrix3dColumn
  #   Matrix3d arg0 --- Matrix [IN]
  #   INT arg1 --- Col [IN]
  def Vector3dFromMatrix3dColumn(arg0, arg1)
    ret = _invoke(1610744217, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromMatrix3dRow
  # method Vector3dFromMatrix3dRow
  #   Matrix3d arg0 --- Matrix [IN]
  #   INT arg1 --- Row [IN]
  def Vector3dFromMatrix3dRow(arg0, arg1)
    ret = _invoke(1610744218, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromTransform3dTimesVector3d
  # method Vector3dFromTransform3dTimesVector3d
  #   Transform3d arg0 --- Transform [IN]
  #   Vector3d arg1 --- Vector [IN]
  def Vector3dFromTransform3dTimesVector3d(arg0, arg1)
    ret = _invoke(1610744219, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromTransform3dTransposeTimesVector3d
  # method Vector3dFromTransform3dTransposeTimesVector3d
  #   Transform3d arg0 --- Transform [IN]
  #   Vector3d arg1 --- Vector [IN]
  def Vector3dFromTransform3dTransposeTimesVector3d(arg0, arg1)
    ret = _invoke(1610744220, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromTransform3dTimesXYZ
  # method Vector3dFromTransform3dTimesXYZ
  #   Transform3d arg0 --- Transform [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Vector3dFromTransform3dTimesXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744221, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromTransform3dTransposeTimesXYZ
  # method Vector3dFromTransform3dTransposeTimesXYZ
  #   Transform3d arg0 --- Transform [IN]
  #   R8 arg1 --- X [IN]
  #   R8 arg2 --- Y [IN]
  #   R8 arg3 --- Z [IN]
  def Vector3dFromTransform3dTransposeTimesXYZ(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744222, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromTransform3dColumn
  # method Vector3dFromTransform3dColumn
  #   Transform3d arg0 --- Transform [IN]
  #   INT arg1 --- Col [IN]
  def Vector3dFromTransform3dColumn(arg0, arg1)
    ret = _invoke(1610744223, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromTransform3dTranslation
  # method Vector3dFromTransform3dTranslation
  #   Transform3d arg0 --- Transform [IN]
  def Vector3dFromTransform3dTranslation(arg0)
    ret = _invoke(1610744224, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Vector3d Vector3dFromTransform3dRow
  # method Vector3dFromTransform3dRow
  #   Transform3d arg0 --- Transform [IN]
  #   INT arg1 --- Row [IN]
  def Vector3dFromTransform3dRow(arg0, arg1)
    ret = _invoke(1610744225, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_I4])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _SavedViewElement CreateSavedViewElement
  #   VARIANT arg0 --- ViewSpecifier [IN]
  #   BSTR arg1 --- Name [IN]
  #   BSTR arg2 --- Description [IN]
  def CreateSavedViewElement(arg0, arg1, arg2 = nil)
    ret = _invoke(1610744226, [arg0, arg1, arg2], [VT_VARIANT, VT_BSTR, VT_BSTR])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddModelActivateEventsHandler
  #   IModelActivateEvents arg0 --- EventHandler [IN]
  def AddModelActivateEventsHandler(arg0)
    ret = _invoke(1610744229, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveModelActivateEventsHandler
  #   IModelActivateEvents arg0 --- EventHandler [IN]
  def RemoveModelActivateEventsHandler(arg0)
    ret = _invoke(1610744230, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddViewUpdateEventsHandler
  #   IViewUpdateEvents arg0 --- EventHandler [IN]
  def AddViewUpdateEventsHandler(arg0)
    ret = _invoke(1610744231, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveViewUpdateEventsHandler
  #   IViewUpdateEvents arg0 --- EventHandler [IN]
  def RemoveViewUpdateEventsHandler(arg0)
    ret = _invoke(1610744232, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddLevelChangeEventsHandler
  #   ILevelChangeEvents arg0 --- EventHandler [IN]
  def AddLevelChangeEventsHandler(arg0)
    ret = _invoke(1610744233, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveLevelChangeEventsHandler
  #   ILevelChangeEvents arg0 --- EventHandler [IN]
  def RemoveLevelChangeEventsHandler(arg0)
    ret = _invoke(1610744234, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Ray3d Ray3dFromXYZXYZStartEnd
  # method Ray3dFromXYZXYZStartEnd
  #   R8 arg0 --- X0 [IN]
  #   R8 arg1 --- Y0 [IN]
  #   R8 arg2 --- Z0 [IN]
  #   R8 arg3 --- X1 [IN]
  #   R8 arg4 --- Y1 [IN]
  #   R8 arg5 --- Z1 [IN]
  def Ray3dFromXYZXYZStartEnd(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610744238, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Ray3d Ray3dFromPoint3dStartEnd
  # method Ray3dFromPoint3dStartEnd
  #   Point3d arg0 --- Point0 [IN]
  #   Point3d arg1 --- Point1 [IN]
  def Ray3dFromPoint3dStartEnd(arg0, arg1)
    ret = _invoke(1610744239, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Ray3d Ray3dFromPoint3dStartTangent
  # method Ray3dFromPoint3dStartTangent
  #   Point3d arg0 --- Point0 [IN]
  #   Point3d arg1 --- Tangent [IN]
  def Ray3dFromPoint3dStartTangent(arg0, arg1)
    ret = _invoke(1610744240, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromRay3dFractionParameter
  # method Point3dFromRay3dFractionParameter
  #   Ray3d arg0 --- Ray [IN]
  #   R8 arg1 --- Fraction [IN]
  def Point3dFromRay3dFractionParameter(arg0, arg1)
    ret = _invoke(1610744241, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Ray3dRay3dIntersectXY
  # method Ray3dRay3dIntersectXY
  #   Ray3d arg0 --- Ray0 [IN]
  #   Ray3d arg1 --- Ray1 [IN]
  #   Point3d arg2 --- Point0 [IN/OUT]
  #   R8 arg3 --- Fraction0 [IN/OUT]
  #   Point3d arg4 --- Point1 [IN/OUT]
  #   R8 arg5 --- Fraction1 [IN/OUT]
  def Ray3dRay3dIntersectXY(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610744242, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Ray3dRay3dClosestApproach
  # method Ray3dRay3dClosestApproach
  #   Ray3d arg0 --- Ray0 [IN]
  #   Ray3d arg1 --- Ray1 [IN]
  #   Point3d arg2 --- Point0 [IN/OUT]
  #   R8 arg3 --- Fraction0 [IN/OUT]
  #   Point3d arg4 --- Point1 [IN/OUT]
  #   R8 arg5 --- Fraction1 [IN/OUT]
  def Ray3dRay3dClosestApproach(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610744243, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Ray3dLength
  # method Ray3dLength
  #   Ray3d arg0 --- Ray [IN]
  def Ray3dLength(arg0)
    ret = _invoke(1610744244, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Ray3dLengthSquared
  # method Ray3dLengthSquared
  #   Ray3d arg0 --- Ray [IN]
  def Ray3dLengthSquared(arg0)
    ret = _invoke(1610744245, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Segment3d Segment3dFromXYZXYZStartEnd
  # method Segment3dFromXYZXYZStartEnd
  #   R8 arg0 --- X0 [IN]
  #   R8 arg1 --- Y0 [IN]
  #   R8 arg2 --- Z0 [IN]
  #   R8 arg3 --- X1 [IN]
  #   R8 arg4 --- Y1 [IN]
  #   R8 arg5 --- Z1 [IN]
  def Segment3dFromXYZXYZStartEnd(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610744246, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_R8, VT_R8, VT_R8, VT_R8, VT_R8, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Segment3d Segment3dFromPoint3dStartEnd
  # method Segment3dFromPoint3dStartEnd
  #   Point3d arg0 --- Point0 [IN]
  #   Point3d arg1 --- Point1 [IN]
  def Segment3dFromPoint3dStartEnd(arg0, arg1)
    ret = _invoke(1610744247, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Segment3d Segment3dFromPoint3dStartTangent
  # method Segment3dFromPoint3dStartTangent
  #   Point3d arg0 --- Point0 [IN]
  #   Point3d arg1 --- Tangent [IN]
  def Segment3dFromPoint3dStartTangent(arg0, arg1)
    ret = _invoke(1610744248, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromSegment3dFractionParameter
  # method Point3dFromSegment3dFractionParameter
  #   Segment3d arg0 --- Segment [IN]
  #   R8 arg1 --- Fraction [IN]
  def Point3dFromSegment3dFractionParameter(arg0, arg1)
    ret = _invoke(1610744249, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromSegment3dTangent
  # method Point3dFromSegment3dTangent
  #   Segment3d arg0 --- Segment [IN]
  def Point3dFromSegment3dTangent(arg0)
    ret = _invoke(1610744250, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Segment3dSegment3dIntersectXY
  # method Segment3dSegment3dIntersectXY
  #   Segment3d arg0 --- Segment0 [IN]
  #   Segment3d arg1 --- Segment1 [IN]
  #   Point3d arg2 --- Point0 [IN/OUT]
  #   R8 arg3 --- Fraction0 [IN/OUT]
  #   Point3d arg4 --- Point1 [IN/OUT]
  #   R8 arg5 --- Fraction1 [IN/OUT]
  def Segment3dSegment3dIntersectXY(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610744251, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Segment3dSegment3dClosestApproach
  # method Segment3dSegment3dClosestApproach
  #   Segment3d arg0 --- Segment0 [IN]
  #   Segment3d arg1 --- Segment1 [IN]
  #   Point3d arg2 --- Point0 [IN/OUT]
  #   R8 arg3 --- Fraction0 [IN/OUT]
  #   Point3d arg4 --- Point1 [IN/OUT]
  #   R8 arg5 --- Fraction1 [IN/OUT]
  def Segment3dSegment3dClosestApproach(arg0, arg1, arg2, arg3, arg4, arg5)
    ret = _invoke(1610744252, [arg0, arg1, arg2, arg3, arg4, arg5], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Segment3dLength
  # method Segment3dLength
  #   Segment3d arg0 --- Segment [IN]
  def Segment3dLength(arg0)
    ret = _invoke(1610744253, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # R8 Segment3dLengthSquared
  # method Segment3dLengthSquared
  #   Segment3d arg0 --- Segment [IN]
  def Segment3dLengthSquared(arg0)
    ret = _invoke(1610744254, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Matrix3d Matrix3dFromRotationBetweenVectors
  # method Matrix3dFromRotationBetweenVectors
  #   Point3d arg0 --- Vector0 [IN]
  #   Point3d arg1 --- Vector1 [IN]
  def Matrix3dFromRotationBetweenVectors(arg0, arg1)
    ret = _invoke(1610744255, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Segment3dClosestPoint
  # method Segment3dClosestPoint
  #   Segment3d arg0 --- Segment [IN]
  #   Point3d arg1 --- SpacePoint [IN]
  #   Point3d arg2 --- ClosePoint [IN/OUT]
  #   R8 arg3 --- CloseFraction [IN/OUT]
  def Segment3dClosestPoint(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744256, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Segment3dClosestPointBounded
  # method Segment3dClosestPointBounded
  #   Segment3d arg0 --- Segment [IN]
  #   Point3d arg1 --- SpacePoint [IN]
  #   Point3d arg2 --- ClosePoint [IN/OUT]
  #   R8 arg3 --- CloseFraction [IN/OUT]
  def Segment3dClosestPointBounded(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744257, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Segment3dClosestPointXY
  # method Segment3dClosestPointXY
  #   Segment3d arg0 --- Segment [IN]
  #   Point3d arg1 --- SpacePoint [IN]
  #   Point3d arg2 --- ClosePoint [IN/OUT]
  #   R8 arg3 --- CloseFraction [IN/OUT]
  def Segment3dClosestPointXY(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744258, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Segment3dClosestPointBoundedXY
  # method Segment3dClosestPointBoundedXY
  #   Segment3d arg0 --- Segment [IN]
  #   Point3d arg1 --- SpacePoint [IN]
  #   Point3d arg2 --- ClosePoint [IN/OUT]
  #   R8 arg3 --- CloseFraction [IN/OUT]
  def Segment3dClosestPointBoundedXY(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744259, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Point3d Point3dFromRay3dTangent
  # method Point3dFromRay3dTangent
  #   Ray3d arg0 --- Ray [IN]
  def Point3dFromRay3dTangent(arg0)
    ret = _invoke(1610744260, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Ray3dClosestPoint
  # method Ray3dClosestPoint
  #   Ray3d arg0 --- Ray [IN]
  #   Point3d arg1 --- SpacePoint [IN]
  #   Point3d arg2 --- ClosePoint [IN/OUT]
  #   R8 arg3 --- CloseFraction [IN/OUT]
  def Ray3dClosestPoint(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744261, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Ray3dClosestPointBounded
  # method Ray3dClosestPointBounded
  #   Ray3d arg0 --- Ray [IN]
  #   Point3d arg1 --- SpacePoint [IN]
  #   Point3d arg2 --- ClosePoint [IN/OUT]
  #   R8 arg3 --- CloseFraction [IN/OUT]
  def Ray3dClosestPointBounded(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744262, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Ray3dClosestPointXY
  # method Ray3dClosestPointXY
  #   Ray3d arg0 --- Ray [IN]
  #   Point3d arg1 --- SpacePoint [IN]
  #   Point3d arg2 --- ClosePoint [IN/OUT]
  #   R8 arg3 --- CloseFraction [IN/OUT]
  def Ray3dClosestPointXY(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744263, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID Ray3dClosestPointBoundedXY
  # method Ray3dClosestPointBoundedXY
  #   Ray3d arg0 --- Ray [IN]
  #   Point3d arg1 --- SpacePoint [IN]
  #   Point3d arg2 --- ClosePoint [IN/OUT]
  #   R8 arg3 --- CloseFraction [IN/OUT]
  def Ray3dClosestPointBoundedXY(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744264, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Segment3d Segment3dFromTransform3dTimesSegment3d
  # method Segment3dFromTransform3dTimesSegment3d
  #   Transform3d arg0 --- Transform [IN]
  #   Segment3d arg1 --- Segment [IN]
  def Segment3dFromTransform3dTimesSegment3d(arg0, arg1)
    ret = _invoke(1610744265, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Ray3d Ray3dFromTransform3dTimesRay3d
  # method Ray3dFromTransform3dTimesRay3d
  #   Transform3d arg0 --- Transform [IN]
  #   Ray3d arg1 --- Ray [IN]
  def Ray3dFromTransform3dTimesRay3d(arg0, arg1)
    ret = _invoke(1610744266, [arg0, arg1], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Segment3d Segment3dFromRay3d
  # method Segment3dFromRay3d
  #   Ray3d arg0 --- Ray [IN]
  def Segment3dFromRay3d(arg0)
    ret = _invoke(1610744267, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Ray3d Ray3dFromSegment3d
  # method Ray3dFromSegment3d
  #   Segment3d arg0 --- Segment [IN]
  def Ray3dFromSegment3d(arg0)
    ret = _invoke(1610744268, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Ray3dPlane3dIntersect
  # method Ray3dPlane3dIntersect
  #   Ray3d arg0 --- Ray [IN]
  #   Plane3d arg1 --- Plane [IN]
  #   Point3d arg2 --- Point [IN/OUT]
  #   R8 arg3 --- Fraction [IN/OUT]
  def Ray3dPlane3dIntersect(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744269, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Segment3dPlane3dIntersect
  # method Segment3dPlane3dIntersect
  #   Segment3d arg0 --- Segment [IN]
  #   Plane3d arg1 --- Plane [IN]
  #   Point3d arg2 --- Point [IN/OUT]
  #   R8 arg3 --- Fraction [IN/OUT]
  def Segment3dPlane3dIntersect(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744270, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddModelChangeEventsHandler
  #   IModelChangeEvents arg0 --- EventHandler [IN]
  def AddModelChangeEventsHandler(arg0)
    ret = _invoke(1610744271, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveModelChangeEventsHandler
  #   IModelChangeEvents arg0 --- EventHandler [IN]
  def RemoveModelChangeEventsHandler(arg0)
    ret = _invoke(1610744272, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Plane3dIntersectsRay3d
  #   Point3d arg0 --- IntersectionPoint [IN/OUT]
  #   R8 arg1 --- Parameter [IN/OUT]
  #   Plane3d arg2 --- Plane [IN/OUT]
  #   Ray3d arg3 --- Ray [IN/OUT]
  def Plane3dIntersectsRay3d(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744273, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_R8, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Plane3dIntersectsPlane3d
  #   Ray3d arg0 --- IntersectionRay [IN/OUT]
  #   Plane3d arg1 --- Plane0 [IN/OUT]
  #   Plane3d arg2 --- Plane1 [IN/OUT]
  def Plane3dIntersectsPlane3d(arg0, arg1, arg2)
    ret = _invoke(1610744274, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # Transform3d Transform3dFromTransform3dTimesTransform3dTimesTransform3d
  #   Transform3d arg0 --- Transform1 [IN/OUT]
  #   Transform3d arg1 --- Transform2 [IN/OUT]
  #   Transform3d arg2 --- Transform3 [IN/OUT]
  def Transform3dFromTransform3dTimesTransform3dTimesTransform3d(arg0, arg1, arg2)
    ret = _invoke(1610744275, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # BOOL Range3dIntersect2
  #   Range3d arg0 --- ResultRange [IN/OUT]
  #   Range3d arg1 --- Range1 [IN/OUT]
  #   Range3d arg2 --- Range2 [IN/OUT]
  def Range3dIntersect2(arg0, arg1, arg2)
    ret = _invoke(1610744276, [arg0, arg1, arg2], [VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH, VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _ElementEnumerator AssembleComplexStringsAndShapes
  #   ChainableElement arg0 --- ChainableElements [IN/OUT]
  #   R8 arg1 --- GapTolerance [IN] ( = -1.0)
  def AssembleComplexStringsAndShapes(arg0, arg1 = nil)
    ret = _invoke(1610744278, [arg0, arg1], [VT_BYREF | VT_ARRAY | VT_BYREF | VT_DISPATCH, VT_R8])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _TransientElementContainer CreateTransientElementContainer1
  #   _Element arg0 --- TransientElement [IN]
  #   MsdTransientFlags arg1 --- Flags [IN]
  #   MsdViewMask arg2 --- ViewMask [IN]
  #   MsdDrawingMode arg3 --- DrawMode [IN]
  def CreateTransientElementContainer1(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744283, [arg0, arg1, arg2, arg3], [VT_BYREF | VT_DISPATCH, VT_DISPATCH, VT_DISPATCH, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _PropertyHandler CreatePropertyHandler
  #   UNKNOWN arg0 --- PropertySource [IN]
  def CreatePropertyHandler(arg0)
    ret = _invoke(1610744284, [arg0], [VT_UNKNOWN])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddEnterIdleEventHandler
  #   IEnterIdleEvent arg0 --- EventHandler [IN]
  def AddEnterIdleEventHandler(arg0)
    ret = _invoke(1610744287, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveEnterIdleEventHandler
  #   IEnterIdleEvent arg0 --- EventHandler [IN]
  def RemoveEnterIdleEventHandler(arg0)
    ret = _invoke(1610744288, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID AddBatchConverterEventsHandler
  #   IBatchConverterEvents arg0 --- EventHandler [IN]
  def AddBatchConverterEventsHandler(arg0)
    ret = _invoke(1610744289, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # VOID RemoveBatchConverterEventsHandler
  #   IBatchConverterEvents arg0 --- EventHandler [IN]
  def RemoveBatchConverterEventsHandler(arg0)
    ret = _invoke(1610744290, [arg0], [VT_BYREF | VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end

  # _SharedCellElement CreateSharedCellElement4
  #   BSTR arg0 --- CellName [IN]
  #   _ModelReference arg1 --- DestinationModel [IN]
  #   BOOL arg2 --- TrueScale [IN]
  #   MsdSharedCellSearch arg3 --- SearchControl [IN]
  def CreateSharedCellElement4(arg0, arg1, arg2, arg3)
    ret = _invoke(1610744291, [arg0, arg1, arg2, arg3], [VT_BSTR, VT_BYREF | VT_DISPATCH, VT_BOOL, VT_DISPATCH])
    @lastargs = WIN32OLE::ARGV
    ret
  end
end
