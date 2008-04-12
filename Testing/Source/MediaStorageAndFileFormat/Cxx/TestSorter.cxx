/*=========================================================================

  Program: GDCM (Grass Root DICOM). A DICOM library
  Module:  $URL$

  Copyright (c) 2006-2008 Mathieu Malaterre
  All rights reserved.
  See Copyright.txt or http://gdcm.sourceforge.net/Copyright.html for details.

     This software is distributed WITHOUT ANY WARRANTY; without even
     the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
     PURPOSE.  See the above copyright notice for more information.

=========================================================================*/
#include "gdcmSorter.h"
#include "gdcmTesting.h"

int TestSorter(int argc, char *argv[])
{
  const char *directory = gdcm::Testing::GetDataRoot();
  if( argc == 2 )
    {
    directory = argv[1];
    }
  gdcm::Directory d;
  unsigned int nfiles = d.Load( directory ); // no recursion
  d.Print( std::cout );
  std::cout << "done retrieving file list. " << nfiles << " files found." <<  std::endl;

  gdcm::Sorter s;
  bool b = s.Sort( d.GetFilenames() );
/*
  if( !b )
    {
    std::cerr << "Failed to sort:" << directory << std::endl;
    return 1;
    }

  std::cout << "Sorting succeeded:" << std::endl;
  s.Print( std::cout );
*/
  return 0;
}
